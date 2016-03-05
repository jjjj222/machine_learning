#!/usr/bin/ruby


#------------------------------------------------------------------------------
#   args
#------------------------------------------------------------------------------
if ARGV.length != 2
    puts "usage: id3.rb <data_file> <attribute_file>"
    exit
end

if ARGV[0]  == "-t"
    data_file_name = "./data/#{ARGV[1]}/#{ARGV[1]}.data"
    attr_file_name = "./data/#{ARGV[1]}/#{ARGV[1]}.attribute"
else
    data_file_name = ARGV[0]
    attr_file_name = ARGV[1]
end

if !File.readable? data_file_name
    puts "Error: Can't open data file \"#{data_file_name}\" !!"
    exit
end

if !File.readable? attr_file_name
    puts "Error: Can't open attribute file \"#{attr_file_name}\" !!"
    exit
end

#------------------------------------------------------------------------------
#   dump
#------------------------------------------------------------------------------
module Enumerable
    def dump
        if self.empty?
            puts "<empty>"
        else
            self.each_with_index do |line, i|
                print "#{i} : "
                print line
                puts
            end
        end
    end

    def dump_indent(indent)
        self.each_with_index do |line, i|
            print "#{indent}#{i} : "
            print line
            puts
        end
    end
end

#------------------------------------------------------------------------------
#   printer
#------------------------------------------------------------------------------
class Printer
    def initialize(width)
        @width = width
    end

    def draw_line(text, c)
        rest = @width - text.length - 2
        rest_left = rest / 2
        rest_right = rest - rest_left

        puts "#{c * rest_left} #{text} #{c * rest_right}"
    end

    def draw_box(text, c)
        rest = @width - text.length - 2
        rest_left = rest / 2
        rest_right = rest - rest_left

        puts c * @width
        puts "#{c}#{' ' * rest_left}#{text}#{' ' * rest_right}#{c}"
        puts c * @width
    end

    def draw_table(data, header)
        widths = get_widths(data + header)
        total_width = widths.inject(0) { |sum, elt| sum += elt}
            + 3 * widths.length + 1

        draw_table_line(widths)
        header.each do |row|
            draw_table_row_left(row, widths)
        end

        draw_table_line(widths)
        data.each do |row|
            draw_table_row(row, widths)
        end
        draw_table_line(widths)
    end

    def draw_table_line(widths)
        print "+"
        widths.each do |width|
            print "-" * (width+2)
            print "+"
        end
        puts
    end

    def draw_table_row_left(row, widths)
        print "|"
        widths.each_with_index do |width, i|
            print " #{row[i].to_s.ljust(width)} |"
        end
        puts
    end

    def draw_table_row(row, widths)
        print "|"
        widths.each_with_index do |width, i|
            print " #{row[i].to_s.rjust(width)} |"
        end
        puts
    end

    private
    def get_widths(rows)
        widths = Array.new(rows[0].length, 0)

        rows.each do |row|
            row_widths = row.map {|elt| elt.to_s.length}
            widths = [widths, row_widths].transpose.map(&:max)
        end

        return widths
    end
end

#------------------------------------------------------------------------------
#   parse
#------------------------------------------------------------------------------
class IO
    def self.parse_data(file)
        lines = IO.readlines(file)
        data = lines.map do |line|
            line.rstrip.gsub(/\s+/, "").split(",")
        end
        return data
    end
end

#------------------------------------------------------------------------------
#   Attribute
#------------------------------------------------------------------------------
class Attribute
    attr_reader :name
    attr_reader :values

    def initialize(raw_attribute)
        raise if raw_attribute.length != 2
        raise if !["d", "c"].include? raw_attribute[1]

        @name = raw_attribute[0]
        @type = raw_attribute[1]
        @values = []

        @missing_count = 0
        @total_count = 0
    end

    def add_value(value)
        @total_count += 1

        if value == "?"
            @missing_count += 1
            return
        end

        if continuous?
            if @values[0] == nil || @values[0] > value.to_f
                @values[0] = value.to_f
            end
            if @values[1] == nil || @values[1] < value.to_f
                @values[1] = value.to_f
            end
        else
            @values |= [value]
        end
    end

    def continuous?
        @type == "c"
    end

    #def to_s
    #    "#{@name} (#{@type}) #{@values.to_s}"
    #end
end

class Range
    def initialize(min, max)
        @min = min
        @max = max
    end

    def ==(rhs)
        self.class === rhs &&
        rhs.min == @min &&
        rhs.max == @max
    end
    alias eql? ==

    def include?(value)
        (@min == nil || @min <= value) && (@max == nil || @max > value)
    end

    def hash
        @min.hash ^ @max.hash
    end

    def to_s
        "[#{@min}, #{@max})"
    end
end

#------------------------------------------------------------------------------
#   LearningData
#------------------------------------------------------------------------------
class LearningData
    attr_reader :examples
    @@random_seed = 0
    @@attributes = nil
    def initialize(examples)
        @examples = examples
    end

    def information_gain_with_split(attribute)
        if attribute.continuous?
            information_gain_with_split_continuous(attribute)
        else
            information_gain_with_split_discrete(attribute)
        end
    end

    def information_gain_with_split_discrete(attribute)
        gain = entropy
        current_split = split_discrete(attribute)

        current_split.each do |key, data|
            ratio = data.length.to_f / length
            gain -= ratio * data.entropy
        end

        return [gain, current_split]
    end

    def information_gain_with_split_continuous(attribute)
        gain = entropy

        points = split_points(attribute)
        if points.empty?
            return [-1 * Float::MAX, nil]
        end

        all_gain_with_split = points.map do |value|
            current_split = split_at(attribute, value)
            current_gain = current_split.each_value.inject(gain) do |sum, data|
                ratio = data.length.to_f / length
                sum -= ratio * data.entropy
            end
            [current_gain, current_split]
        end

        return all_gain_with_split.max_by {|gain_with_split| gain_with_split[0]}
    end

    def split_discrete(attribute)
        i = @@attributes.index(attribute)

        hash = Hash.new { |h, k| h[k] = [] }
        @examples.each do |example|
            hash[example[i]] << example
        end

        if hash.key? "?"
            unknowns = hash.delete("?")
            #unknowns.dump
            sample_array = []
            hash.each do |key, value|
                sample_array += ([key] * value.length)
            end
            #sample_array.dump

            rng = Random.new(@@random_seed)
            unknowns.each do |example|
                #key = sample_array.sample(1, random: Random.new(@@random_seed))
                key = sample_array.sample(random: rng)
                #puts "#{example} => #{key}"
                hash[key] << example
            end
            #raise
        end

        attribute.values.each do |value|
            hash[value] = LearningData.new(hash[value])
        end

        return hash
    end

    #def split_continuous(attribute)
    #    #min_value = split_points(attribute).min_by do |value|
    #    all_split = split_points(attribute).map do |value|
    #        current_split = split_at(attribute, value)
    #        current_split.each_value.inject(0.0) do |sum, data|
    #            sum += data.entropy
    #        end
    #    end

    #    return split_at(attribute, min_value)
    #end

    def split_at(attribute, value)
        #puts @examples.length
        #@examples.dump
        raise if !attribute.continuous?

        i = @@attributes.index(attribute)

        unknown = []
        greater = []
        lesser = []
        @examples.each do |example|
            if example[i] == "?"
                unknown << example
                #puts example[i].to_f
                #raise
                next
            end

            if example[i].to_f >= value
                greater << example
            else
                lesser << example
            end
        end
            #raise

        if !unknown.empty?
            #unknown.dump
            sample_array = [0] * lesser.length
            sample_array += [1] * greater.length
            #sample_array.dump
            rng = Random.new(@@random_seed)
            unknown.each do |example|
                key = sample_array.sample(random: rng)
                if (key == 0)
                    lesser << example
                else
                    greater << example
                end
            end
        end

        {Range.new(nil, value)=>LearningData.new(lesser), Range.new(value, nil)=>LearningData.new(greater)}
    end

    def split_points(attribute)
        #i = @attributes.index(attribute)
        i = @@attributes.index(attribute)

        #puts @examples.length
        values = @examples.map do |example|
            if example[i] == "?"
                "?"
            else
                example[i].to_f
            end

        end
        values.delete("?")
        #puts values.length
        #values.dump
        #raise

        result = []
        values.sort.uniq.each_cons(2) do |value|
            result << (value[0].to_f + value[1].to_f) / 2
        end
        return result
    end

    def entropy
        hash = Hash.new(0)
        @examples.each do |example|
            value = example[-1]
            hash[value] += 1
        end

        sum = 0.0
        hash.each_value do |value|
            ratio = value.to_f / @examples.length
            sum += -1 * ratio * Math.log2(ratio)
        end
        return sum
    end

    def error_count
        hash = class_count
        correct_count = hash.max_by { |k, v| v}[1]
        return @examples.length - correct_count
    end

    def majority
        hash = class_count
        hash.max_by { |k, v| v}[0]
    end

    def class_count
        hash = Hash.new(0)

        #@attributes[-1].values.each do |value|
        @@attributes[-1].values.each do |value|
            hash[value] = 0
        end

        @examples.each do |example|
            value = example[-1]
            hash[value] += 1
        end
        return hash
    end

    def length ; @examples.length ; end
    def empty? ; @examples.empty? ; end

    def same_class?
        return nil if empty? 

        classification = @examples[0][-1]
        @examples.each do |example|
            return nil if example[-1] != classification
        end
        return classification
    end

    def class_count_str
        str = "["
        is_first = true;
        class_count.each do |key, value|
            if is_first
                is_first = false
            else
                str += ", "
            end
            str+= "#{value} #{key}"
        end
        str += "]"

        return str
    end

    def self.get_index_by_attribute_name(name)
        i = @@attributes.index {|attribute| attribute.name == name}
    end

    def self.attributes=(attributes)
        @@attributes = attributes
    end
    def self.attributes
        @@attributes
    end

    #def get_class
    #    @examples[0][-1]
    #end

    #def to_s
    #    @data.to_s
    #end

    # debug
    def dump
        @examples.dump
        #puts
        #@attributes.dump
        #@attributes.dump
    end
    def dump_examples ; @examples.dump ; end
    #def dump_attributes ; @attributes.dump ; end
end

#------------------------------------------------------------------------------
#   
#------------------------------------------------------------------------------
class TreeNode
    attr_accessor :childs
    attr_accessor :class, :attribute, :value
    attr_accessor :choose
    attr_reader :data
    #attr_accessor :class_hash
    @@random_seed = 0
    @@classify_rng = Random.new(@@random_seed)

    def initialize(data)
        @class = nil
        @attribute = nil
        @value = nil
        @choose = nil
        @data = data
        @childs = []
    end

    def clone
        result = self.dup
        result.childs = @childs.map do |child|
            child.clone
        end
        return result
    end

    def get_self_error_count
        @data.error_count
    end

    def get_leaf_error_count
        if @childs.empty?
            return get_self_error_count
        end

        @childs.inject(0) do |sum, child|
            sum += child.get_leaf_error_count
        end
    end

    def get_leaf_count
        if @childs.empty?
            return 1
        end

        @childs.inject(0) do |sum, child|
            sum += child.get_leaf_count
        end
    end

    def get_alpha
        if is_leaf?
            return Float::MAX
        end

        error_diff = get_self_error_count - get_leaf_error_count
        return (error_diff.to_f / @data.length) / (get_leaf_count - 1)
    end

    def get_node_with_smallest_alpha
        if is_leaf?
            return [self, get_alpha]
        end

        child_min = @childs.map do |child|
            child.get_node_with_smallest_alpha
        end.min_by {|node, alpha| alpha}

        self_alpha = get_alpha
        if self_alpha < child_min[1]
            return [self, self_alpha]
        else
            return child_min
        end
    end

    def get_info_str
        str = "root"
        if @attribute != nil
            str = "#{@attribute}=#{@value}"
        end

        if @class != nil
            str +=", class=#{@class}"
        end

        return str
    end

    def test_error(examples)
        examples.inject(0) do |sum, example|
            #sum += 1
            sum += 1 if classify(example) != example[-1]
            #print example
            #result = classify(example)
            #puts " => #{result} => #{result == example[-1]}"
            sum
        end
    end

    def classify(example)
        if @class != nil
            return @class
        end

        i = LearningData.get_index_by_attribute_name(@choose)
        if example[i] == "?"
            sample_array = []
            @childs.each do |child|
                sample_array += ([child] * child.data.length)
            end
            return sample_array.sample(random: @@classify_rng).classify(example)
            #sample_array.dump
            #p @data.length
            #raise
            #rng = Random.new(@@random_seed)
            #unknowns.each do |example|
            #    #key = sample_array.sample(1, random: Random.new(@@random_seed))
            #    key = sample_array.sample(random: rng)
            #    #puts "#{example} => #{key}"
            #    hash[key] << example
            #end
        end

        matched_child = @childs.find do |child|
            child.match(example)
        end
        return matched_child.classify(example)
    end

    def match(example)
        i = LearningData.get_index_by_attribute_name(@attribute)
        if @value.is_a? Range
            return @value.include? example[i].to_f
        else
            return @value == example[i]
        end
    end

    def make_leaf
        @childs = []
        @class = @data.majority
    end

    def is_leaf?
        return @childs.empty?
    end

    # Debug
    def dump
        puts "class=#{@class}"
        puts "#{@attribute}=#{@value}"
    end

    def dump_tree
        dump_tree_rec("")
    end

    def dump_tree_rec(indent, is_last = true)
        print indent
        print is_last ? " `- " : " |- "
        print "#{get_info_str} #{@data.class_count_str}"
        #print " #{get_self_error_count}-#{get_leaf_error_count}/#{get_leaf_count}"
        #print " a: #{get_alpha}"
        puts

        indent += is_last ? "    " : " |  "
        #@data.examples.dump_indent(indent + " * ")
        childs.each_with_index do |child, i|
            child.dump_tree_rec(indent, i == childs.length - 1)
        end
    end
end

class ID3
    @@random_seed = 0
    @@prune_ratio = 3

    def initialize(examples, attributes)
        LearningData.attributes = attributes

        examples.shuffle!(random: Random.new(@@random_seed))

        num_of_learning_example = examples.length - examples.length / @@prune_ratio
        learning_examples = examples[0...num_of_learning_example]
        @prune_examples = examples[num_of_learning_example..-1]
        @data = LearningData.new(learning_examples)

        build
    end

    def build
        @root = build_rec(@data, LearningData.attributes[0...-1])
    end

    def build_rec(data, attributes)
        raise if data.empty?

        node = TreeNode.new(data)

        data_class = data.same_class?
        if data_class
            node.class = data_class
            return node
        end

        if attributes.empty?
            node.class = data.majority
            return node
        end

        all_decisions = attributes.map do |attribute|
            [attribute, data.information_gain_with_split(attribute)]
        end
        #decision = attributes.max_by do |attribute|
        #    data.information_gain(attribute)
        #end
        current_decision = all_decisions.max_by do |decision|
            decision[1][0]
        end
        #puts ">>> choose #{decision.to_s} : #{data.information_gain(decision)}"

        if current_decision[1][0]  <= 0
            node.class = data.majority
            return node
        end
        #if data.information_gain(decision)  <= 0
        #    node.class = data.majority
        #    return node
        #end

        if current_decision[0].continuous?
            new_attributes = attributes.dup
        else
            new_attributes = attributes - [current_decision[0]]
        end
        #if decision.continuous?
        #    new_attributes = attributes.dup
        #else
        #    new_attributes = attributes - [decision]
        #end

        node.choose = current_decision[0].name
        #data.split(decision).each do |key, new_data|
        current_decision[1][1].each do |key, new_data|
            #puts key
            #new_data.dump
            if new_data.empty?
                child = TreeNode.new(new_data)
                child.class = data.majority
            else
                child = build_rec(new_data, new_attributes)
            end

            #child.attribute = decision.name
            child.attribute = current_decision[0].name
            child.value = key
            node.childs << child
        end

        return node
    end

    def prune
        candidate_tree = []
        
        #error_min = @examples.length
        while !@root.is_leaf?
            #leaf_error_count = @root.get_leaf_error_count
            #error_min = leaf_error_count if leaf_error_count < error_min

            candidate_tree << @root.clone
            node_with_smallest_alpha = @root.get_node_with_smallest_alpha
            node = node_with_smallest_alpha[0]
            #node.dump_tree

            node.make_leaf
        end
        candidate_tree << @root.clone
        #candidate_tree.reverse

        #@prune_examples.dump

        #puts "# of candidate = #{candidate_tree.length}"
        #candidate_tree.each do |tree|
        #    puts tree.test_error(@prune_examples)
        #    puts tree.test_error(@prune_examples).to_f / @prune_examples.length
            #tree.dump_tree
        #    #raise
        #end

        #error_ratio
        #se = 
        tree_with_error_rate = candidate_tree.map do |tree|
            [tree.test_error(@prune_examples), tree]
        end

        #tree_with_error_rate.each do |tree|
        #    #puts tree[0]
        #    puts tree[0].to_f / @prune_examples.length
        #    tree[1].dump_tree
        #end

        tree_with_min_error_rate = tree_with_error_rate.min_by do |tree_with_error|
            tree_with_error[0]
        end
        #error_min = candidate_tree.map do |tree|
        #    tree.test_error(@prune_examples)
        #end.min
        #puts "error_min = #{error_min}"

        #error_rate = error_min.to_f / @prune_examples.length
        error_rate = tree_with_min_error_rate[0].to_f / @prune_examples.length
        #puts "error_rate = #{error_rate}"
        se = Math.sqrt(error_rate * (1 - error_rate) / @prune_examples.length)
        #puts "SE = #{se}"
        threshold = error_rate + se;
        #puts "threshold = #{threshold}"
        #puts error_min
        #@root = candidate_tree.reverse.find do |tree|
        #    tree.test_error(@prune_examples).to_f / @prune_examples.length <= threshold
        #end
        @root = tree_with_error_rate.reverse.find do |tree_with_error|
            tree_with_error[0].to_f / @prune_examples.length <= threshold
            #tree.test_error(@prune_examples).to_f / @prune_examples.length <= threshold
        end[1]
    end

    def test(examples)
        no_of_error = 0
        examples.each do |example|
            result = @root.classify(example)
            no_of_error += 1 if result != example[-1]
            #print example
            #puts " => #{result} => #{result == example[-1]}"
        end
        return no_of_error
    end

    def learning_examples_length
        @data.length
    end

    def pruning_examples_length
        @prune_examples.length
    end

    def get_leaf_count
        @root.get_leaf_count
    end
    #def test(test_file)
    #    tests = IO.parse_data(test_file)
    #    tests.each do |example|
    #        print example
    #        result = @root.classify(example)
    #        puts " => #{result} => #{result == example[-1]}"
    #    end
    #end
    #def classify(example)
    #    return @root.classify(example)
    #end

    def dump_tree
        puts "ID3 (#{get_leaf_count} leaves)"
        @root.dump_tree
    end
end

#------------------------------------------------------------------------------
#   
#------------------------------------------------------------------------------
class Majority
    attr_reader :class

    def initialize(examples)
        @class = LearningData.new(examples).majority
    end

    def test(examples)
        no_of_error = 0
        examples.each do |example|
            no_of_error += 1 if @class != example[-1]
        end
        return no_of_error
    end
end

#------------------------------------------------------------------------------
#   
#------------------------------------------------------------------------------
class ID3Tester
    @@random_seed = 0
    @@test_ratio = 10
    def initialize(data_file, attr_file)
        @data_file = data_file
        @attr_file = attr_file

        @examples = IO.parse_data(data_file)
        raw_attributes = IO.parse_data(attr_file)

        @attributes = calculate_attributes(@examples, raw_attributes)
        @examples.shuffle!(random: Random.new(@@random_seed))

        @example_partition = Array.new(@@test_ratio) { Array.new }
        @examples.each_slice(@@test_ratio) do |n_examples|
            n_examples.each_with_index do |example, i|
                @example_partition[i] << example
            end
        end
    end

    def test_1
        num_of_learning_example = @examples.length - @examples.length / @@test_ratio
        learning_examples = @examples[0...num_of_learning_example]
        test_examples = @examples[num_of_learning_example..-1]


        id3 = ID3.new(learning_examples, @attributes)
        id3.dump_tree
        id3.prune
        id3.dump_tree
    end

    def cross_validation
        printer = Printer.new(80)
        all_recorder = []
        #i = 0
        (0...@@test_ratio).each do |i|
            #recorder = Recorder.new(i+1)
            recorder = []
            printer.draw_box "round #{i+1}", "="
            recorder << i+1

            learning_examples = get_learning_examples(i)
            test_examples = @example_partition[i]
            #puts "# of learning examples = #{learning_examples.length}"
            #recorder << learning_examples.length
            #puts "# of test examples = #{test_examples.length}"
            #recorder <<

            #puts ">>> before pruning:"
            id3 = ID3.new(learning_examples, @attributes)
            recorder << id3.learning_examples_length
            recorder << id3.pruning_examples_length
            recorder << test_examples.length
            puts "# of learning examples = #{id3.learning_examples_length}"
            puts "# of pruning examples = #{id3.pruning_examples_length}"
            puts "# of test examples = #{test_examples.length}"


            printer.draw_line "before pruning:", "-"
            no_of_error = id3.test(test_examples)
            puts "# of error = #{no_of_error}"
            recorder << id3.get_leaf_count
            recorder << no_of_error
            puts "error rate = #{no_of_error.to_f / test_examples.length}"
            id3.dump_tree


            printer.draw_line "after pruning:", "-"
            #puts ">>> after pruning:"
            id3.prune
            no_of_error = id3.test(test_examples)
            puts "# of error = #{no_of_error}"
            recorder << id3.get_leaf_count
            recorder << no_of_error
            puts "error rate = #{no_of_error.to_f / test_examples.length}"
            id3.dump_tree

            printer.draw_line "majority classifier", "-"
            majority_classifier = Majority.new(learning_examples)
            no_of_error = majority_classifier.test(test_examples)
            recorder << no_of_error
            puts "# of error = #{no_of_error}"
            puts "error rate = #{no_of_error.to_f / test_examples.length}"
            puts "Majority (class = #{majority_classifier.class})"

            all_recorder << recorder
        end

        printer.draw_box "summary", "#"
        headers_1 = ["round", "learn", "prune", "test", "leaf", "error",
            "leaf", "error", "error"]
        headers_2 = ["", "", "", "", "(orig.)", "(orig.)",
            "(pr.)", "(pr.)", "(major.)"]
        printer.draw_table(all_recorder, [headers_1, headers_2])

        #print_statistics(all_recorder)
        printer.draw_box "statistics", "#"
        test_pos = 3
        before_pos = 5
        after_pos = 7
        majority_pos = 8

        all_info = []

        all_info << ["before"] + [get_avg(all_recorder, 4)] +get_error_statistics(all_recorder, test_pos, before_pos)
        all_info << ["after"] + [get_avg(all_recorder, 6)] + get_error_statistics(all_recorder, test_pos, after_pos)
        all_info << ["majority", "N/A"] + get_error_statistics(all_recorder, test_pos, majority_pos)
        #before_info.dump
        #all_info << ["before"] + before_info
        headers = ["", "leaf", "accuracy", "SE", "95% CI"]
        printer.draw_table(all_info, [headers])
    end

    def get_avg(all_recorder, data_pos)
        avg = all_recorder.inject(0.0) do |sum, record|
            sum += record[data_pos]
        end / all_recorder.length

        return get_print_format(avg)
    end

    def get_error_statistics(all_recorder, test_pos, data_pos)
        accuracy = all_recorder.map do |record|
            #1.0 - (record[data_pos].to_f / record[test_pos])
            ( 1.0 - (record[data_pos].to_f / record[test_pos]) ) * 100
        end

        #accuracy.dump
        return get_statistics(accuracy)
    end

    def get_statistics(data)
        avg = ( data.inject(0.0) {|sum, elt| sum += elt } / data.length)
        #puts avg

        variance = ( data.inject(0.0) {|sum, elt| sum += (elt - avg)**2 } / data.length)
        #puts variance
        se = Math.sqrt(variance)
        #puts se

        tNv = 2.23
        interval_low = avg - se * tNv
        interval_low = 0.0 if interval_low < 0.0
        #puts interval_low
        interval_up = avg + se * tNv
        interval_up = 100.0 if interval_up > 100.0
        #puts interval_up
        interval = "(#{get_print_format(interval_low)}, #{get_print_format(interval_up)})"
        #puts interval
        return [get_print_format(avg), get_print_format(se), interval]
    end

    def get_print_format(data)
        return sprintf("%0.02f", data)
    end

    def get_learning_examples(i_excluded)
        result = []
        @example_partition.each_with_index do |examples, i|
            if i != i_excluded
                result += examples
            end
        end
        return result
    end

    def calculate_attributes(examples, raw_attributes)
        attributes = []
        raw_attributes.each_with_index do |raw_attribute, line|
            if raw_attribute.length != 2
                puts "Error: In file \"#{@attr_file}\" line #{line+1}: number of column should be 2"
                exit
            end
            if !["d", "c"].include? raw_attribute[1]
                puts "Error: In file \"#{@attr_file}\" line #{line+1}: the type should be 'd' or 'c'"
                exit
            end
            attributes << Attribute.new(raw_attribute)
        end

        examples.each_with_index do |example, line|
            if example.length != attributes.length
                puts "Error: In file \"#{@data_file}\" line #{line+1}: \
number of column (#{example.length}) != number of attributes (#{attributes.length})"
                exit
            end
        end


        attributes.each_with_index do |attribute, i|
            examples.each do |example|
                attribute.add_value(example[i])
                #value = example[i]
                #if value == "?"
                #    #attribute.missing_count += 1
                #    next
                #end

                #if attribute.continuous?
                #    if attributes[i].values[0] == nil || attributes[i].values[0] > value.to_f
                #        attributes[i].values[0] = value.to_f
                #    end
                #    if attributes[i].values[1] == nil || attributes[i].values[1] < value.to_f
                #        attributes[i].values[1] = value.to_f
                #    end
                #else
                #    attribute.values |= [value]
                #end
            end
        end
        #examples.each_with_index do |example, line|
        #    if example.length != attributes.length
        #        example.dump
        #        raise "example #{line+1}: example.length(#{example.length})\
        #             != attributes.length(#{attributes.length})"
        #    end

        #    attributes.each_index do |i|
        #        value = example[i]
        #        if value == "?"
        #            #puts "line #{line+1}, attribute #{i+1} is '?'"
        #            next
        #        end

        #        #if attributes[i].type == "d"
        #        if !attributes[i].continuous?
        #            attributes[i].values |= [value]
        #        else # type == "c"
        #            if attributes[i].values[0] == nil || attributes[i].values[0] > value.to_f
        #                attributes[i].values[0] = value.to_f
        #            end
        #            if attributes[i].values[1] == nil || attributes[i].values[1] < value.to_f
        #                attributes[i].values[1] = value.to_f
        #            end
        #        end
        #    end
        #end
        return attributes
    end
end

#------------------------------------------------------------------------------
#   
#------------------------------------------------------------------------------
#id3 = ID3.new(data_file_name, attr_file_name)
#id3.dump_tree
#id3.prune
#id3.dump_tree
#id3.test(test_file_name)
id3_tester = ID3Tester.new(data_file_name, attr_file_name)
#id3_tester.test_1
id3_tester.cross_validation

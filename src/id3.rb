require "./src/data.rb"
require "./src/util.rb"
require "./src/statistics.rb"


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

    def initialize(examples, attributes, setup)
        LearningData.attributes = attributes

        examples.shuffle!(random: Random.new(@@random_seed))

        #num_of_learning_example = examples.length - examples.length / @@prune_ratio
        #learning_examples = examples[0...num_of_learning_example]
        #@prune_examples = examples[num_of_learning_example..-1]

        #learning_examples, @prune_examples = examples.partition_ratio(@@prune_ratio)
        learning_examples, @prune_examples = examples.split_by_ratio(@@prune_ratio)

        @data = LearningData.new(learning_examples)
        #@data = LearningData.new(examples)

        build
        if (setup and setup["prune"] != nil and setup["prune"] == false)
        else
            prune
        end
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
        #data.dump
        #all_decisions.map {|elt| [elt[0].name, elt[1][0]]}.dump
        #exit
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

    def classify(example)
        return @root.classify(example)
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

    def add_record(record)
        record["leaf"] = get_leaf_count
        record["prune"] = @prune_examples.length
        record["build"] = record["learn"] - @prune_examples.length
        #record["learn"] -= @prune_examples.length
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


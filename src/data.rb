require "./src/util.rb"
require "./src/error.rb"
require "./src/statistics.rb"

#------------------------------------------------------------------------------
#   Attribute
#------------------------------------------------------------------------------
class Attribute #static
    def self.parse_attr_file(file)
        raw_attributes = IO.parse_data(file)

        raw_attributes.each_with_index do |raw_attribute, line|
            if raw_attribute.length != 2
                ErrorMsg.file_line(file, line+1, "number of column should be 2")
                exit
            end
            if !["d", "c"].include? raw_attribute[1]
                ErrorMsg.file_line(file, line+1, "the type should be 'd' or 'c'")
                exit
            end
        end

        return raw_attributes
    end

    def self.calculate_attributes(examples, raw_attributes)
        examples_column = examples.transpose

        attributes = []
        raw_attributes.each_with_index do |raw_attribute, i|
            attributes << Attribute.new(raw_attribute, examples_column[i])
        end

        return attributes
    end
end

class Attribute
    attr_reader :name
    attr_reader :values

    def initialize(raw_attribute, values)
        raise if raw_attribute.length != 2
        raise if !["d", "c"].include? raw_attribute[1]

        @name = raw_attribute[0]
        @type = raw_attribute[1]
        @values = []


        if continuous?
            calculate_statistics(values)
        else
            add_values_discrete(values)
        end
    end

    def add_values_discrete(values)
        values.each do |value|
            if value != "?"
                @values |= [value]
            end
        end
    end

    def calculate_statistics(values)
        values.select! {|value| value != "?"}
        values.map! {|value| value.to_f }
        #values.dump
        #@values = values.mean_se
        #@values = values.minmax + values.mean_se
        @values = values.minmax + values.mean_se
    end

    def continuous?
        @type == "c"
    end

    def mean
        @values[2]
    end

    def se
        @values[3]
    end

    def to_s
        "#{@name} (#{@type}) #{@values}"
    end
end

#------------------------------------------------------------------------------
#   LearningData
#------------------------------------------------------------------------------
class LearningData
    def self.parse_data_file(file, num_of_column)
        examples = IO.parse_data(file)

        examples.each_with_index do |example, line|
            if example.length != num_of_column
                ErrorMsg.file_line(file, line+1, "number of column (#{example.length}) != number of attributes (#{num_of_column})")
                exit
            end
        end
    end

    def self.ann_normalize(examples, attributes)
        examples_column = examples.transpose

        attributes.each_with_index do |attribute, i|
            if attribute.continuous?
                examples_column[i].fix_unknown!(attribute.mean)

                examples_column[i].map! {|elt| elt.to_f}
                #examples_column[i].normalize!
                examples_column[i].normalize_by!(attribute.mean, attribute.se)
            else
                examples_column[i].fix_unknown!
            end
        end
        
        return examples_column.transpose
    end
end

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
                #key = sample_array.sample(random: rng)
                key = sample_array.sample({:random => rng})
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
                #key = sample_array.sample(random: rng)
                key = sample_array.sample({:random => rng})
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

    def dump
        @examples.dump
    end
    def dump_examples ; @examples.dump ; end
end

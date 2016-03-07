#------------------------------------------------------------------------------
#   split
#------------------------------------------------------------------------------
module Enumerable
    #def partition(parts)
    #    num_of_learning_example = examples.length - examples.length / @@prune_ratio
    #    learning_examples = examples[0...num_of_learning_example]
    #    @prune_examples = examples[num_of_learning_example..-1]
    #end

    def partition_ratio(ratio)
        num_of_first = length - length / ratio
        first_part = self[0...num_of_first]
        second_part = self[num_of_first..-1]
        return [first_part, second_part]
    end

    def split_at(pos)
        res = []
        res << self[0...pos]
        res << self[pos..-1]
        return res
    end
end

module Enumerable
    def word_count
        #hash = Hash.new { |h, k| h[k] = [] }
        hash = Hash.new(0)
        each do |elt|
            hash[elt] += 1
        end
        return hash
    end
end

module Enumerable
    def inner_product(rhs)
        raise "#{length} != #{rhs.length}" if length != rhs.length

        sum = 0.0
        each_with_index do |elt, i|
            sum += elt * rhs[i]
        end
        return sum
    end
end

class Array
  def reverse_each_with_index &block
    (0...length).reverse_each do |i|
      block.call self[i], i
    end
  end
end

#module Enumerable
#    def deep_dup
#        map {|elt| elt.deep_dup }
#    end
#end

#------------------------------------------------------------------------------
#   Math
#------------------------------------------------------------------------------
module Math
    def self.sigmoid(x)
        #100.0 / (1.0 + Math.exp(-x))
        1.0 / (1.0 + Math.exp(-x))
        #1.1 / (1.0 + Math.exp(-x))
    end
end


#------------------------------------------------------------------------------
#   unknown
#------------------------------------------------------------------------------
class Hash
    def sample_array
        sample_array = []
        each do |key, value|
            sample_array += ([key] * value)
        end
        return sample_array
    end
end

module Enumerable
    def fix_unknown!(value = nil)
        if (value != nil)
            map! do |elt|
                if (elt == "?")
                    value
                else
                    elt
                end
            end
        else
            hash = word_count()
            hash.delete("?")
            sample_array = hash.sample_array()
            #sample_array.dump

            random_seed = 0
            rng = Random.new(random_seed)
            map! do |elt|
                if (elt == "?")
                    sample_array.sample(random: rng)
                else
                    elt
                end
            end
        end
    end
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

    #def dump_indent(indent)
    #    self.each_with_index do |line, i|
    #        print "#{indent}#{i} : "
    #        print line
    #        puts
    #    end
    #end
end

#------------------------------------------------------------------------------
#   parse
#------------------------------------------------------------------------------
class IO
    def self.parse_data(file)
        begin
            lines = IO.readlines(file)
        rescue
            puts "Error: Can't open file \"#{file}\" !!"
            exit
        end

        data = lines.map do |line|
            line.rstrip.gsub(/\s+/, "").split(",")
        end
        return data
    end
end


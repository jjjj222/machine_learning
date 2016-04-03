#------------------------------------------------------------------------------
#   split
#------------------------------------------------------------------------------
module Enumerable
    def split_by_ratio(ratio)
        num_of_first = length - length / ratio
        return split_at(num_of_first)
    end

    def split_at(pos)
        res = []
        res << self[0...pos]
        res << self[pos..-1]
        return res
    end

    def partition_n_parts(n)
        result = Array.new(n) { Array.new }
        self.each_slice(n) do |n_elt|
            n_elt.each_with_index do |elt, i|
                result[i] << elt
            end
        end
        return result
    end

    def merge_all_but(i_excluded)
        result = []
        self.each_with_index do |elt, i|
            if i != i_excluded
                result += elt
            end
        end
        return result
    end
end

#------------------------------------------------------------------------------
#   
#------------------------------------------------------------------------------
module Enumerable
    def word_count
        hash = Hash.new(0)
        each do |elt|
            hash[elt] += 1
        end
        return hash
    end

    def majority
        word_count.max_by { |k, v| v }[0]
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

#------------------------------------------------------------------------------
#   deep_dup
#------------------------------------------------------------------------------
module Enumerable
    def deep_dup
        map {|elt| elt.deep_dup }
    end
end

class Numeric
    def deep_dup
        self
    end
end

class Object
    def deep_dup
        self.dup
    end
end

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
#   Hash
#------------------------------------------------------------------------------
#class Hash
#    get_or
#end

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
                    sample_array.sample({:random => rng})
                    #sample_array.sample(random: rng)
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
        #elsif is_a? Hash
        #    self.each_with_index do |line, i|
        #        print "#{i} : "
        #        print line[0]
        #        print "#{line[0]} => #{line[1]}"
        #        puts
        #    end
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


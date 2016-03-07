#!/usr/bin/ruby

require "./src/data.rb"
#------------------------------------------------------------------------------
#   
#------------------------------------------------------------------------------
#case_name = "iris"
case_name = "example"
file_base_name = "./data/#{case_name}/#{case_name}"
data_file_name = "#{file_base_name}.data"
attr_file_name = "#{file_base_name}.attribute"

class ANN
    #@@partition_ratio = 5

    def initialize(examples, attributes)
        examples_column = examples.transpose

        attributes.each_with_index do |attribute, i|
            if attribute.continuous?
                examples_column[i].fix_unknown!(attribute.mean)

                examples_column[i].map! {|elt| elt.to_f}
                examples_column[i].normalize!
            else
                examples_column[i].fix_unknown!
            end
        end
        
        examples = examples_column.transpose
        examples = LearningData.ann_normalize(examples, attributes)
        #examples.dump
        #attributes.each_with_index do |attribute, i|
        #    if !attribute.continuous?
        #        next
        #    end

        #    examples_column[i].

        #end
        #x = []
        #x.dump

        #attr_map
        examples.map! do |example|
            example_map(example, attributes)
        end
        #examples.dump
        #attributes.dump
        #attributes.dump


        if (attributes[-1].continuous?)
            puts "TODO: if (attributes[-1].continuous?)"
            exit
        else
            width_of_output = attributes[-1].values.length
            width_of_input = examples[0].length - width_of_output
        end
        #puts width_of_output
        #puts width_of_input
        #examples[0].dump
        width_of_hidden_layer = attributes.size - 1
        num_of_hidden_layer = 1
        @x = []

        @x << [0.0] * width_of_input

        #previous_width = width_of_input
        (0...num_of_hidden_layer).each do |i|
            #x << [0.0] * previous_width
            #previous_width = width_of_hidden_layer
            @x << [0.0] * width_of_hidden_layer
        end
        @x << [0.0] * width_of_output

        #@x.dump
        @sigma = @x.map {|elt| elt.dup }
        #@sigma.dump


        @w = []
        @x.each_with_index do |x_row, i|
            if i == 0
                w_row = []
                (0...x_row.length).each do |j|
                    w_row << []
                end
                @w << w_row
                #@w << [[]] * x_row.length
            else
                w_row = []
                (0...x_row.length).each do |j|
                    w_row << [0.0] * (@x[i-1].length + 1)
                end
                #@w << [[1.0] * @x[i-1].length] * x_row.length
                #@w << [[0.0] * (@x[i-1].length + 1)] * x_row.length
                #print w_row; puts
                @w << w_row
            end
        end

        #examples.dump
        #@w.dump
        (0...1000000).each do |qq|
            output = examples[0][width_of_input..-1]
            res = forward_propagate(@x, examples[0][0...width_of_input])
            puts "#{output} #{res}"

            calculate_sigma(res, output)
            back_propagation(@w, @x, @sigma)
        end
    end

    def calculate_sigma(res, output)
        @sigma[-1].each_index do |i|
            @sigma[-1][i] = res[i] * (1.0 - res[i]) * (output[i] - res[i])
            #@sigma[-1][i] = res[i] * (1.0 - res[i]) * (@x[-1][i] - res[i])
        end

        @sigma[1...-1].reverse_each_with_index do |sigma_row, i|
            sigma_row.each_index do |j|
                sum = 0.0
                @w[i+1].each_with_index do |w_elt, k|
                    sum += (w_elt[j] * @sigma[i+1][k])
                end
                #sum += (@sigma[i+1] * @w[i+1][])
                @sigma[i][j] = @x[i][j] * (1.0 - @x[i][j]) * sum
            end
        end

    end

    def back_propagation(w, x, sigma)
        #w.dump
        w.each_index do |i|
            if i == 0
                next
            end

            x_with_1 = x[i-1] + [1.0]

            w[i].each_index do |j|
                w[i][j].each_index do |k|
                    #puts "#{i} #{j} #{k}"
                    #byebug
                    w[i][j][k] += 0.1 * sigma[i][j] * x_with_1[k]
                    #puts w[i][j][k]
                end
            end
        end
        #puts @w[2][0][0]

        #w.dump

    end

    def forward_propagate(x, example)
        x.each_with_index do |x_row, i|
            if (i == 0)
                x[i] = example
            else
                x_row.each_with_index do |x_cell, j|
                    x[i][j] = Math.sigmoid((x[i-1] + [1.0]).inner_product(@w[i][j]))
                end
            end
        end

        #x.dump

        return x[-1]
    end

    def initiate_w(x)
        w = []
        x.each_with_index do |x_row, i|
            if i == 0
                w << [[]] * x_row.length
            else
                w << [[0.0] * (x[i-1].length + 1)] * x_row.length
            end
        end
        return w
    end

    #def inner_prodect(a, b)
    #    
    #end

    def example_map(example, attributes)
        x = []

        attributes.each_with_index do |attribute, i|
            if attribute.continuous?
                x << example[i]
            else
                attribute.values.each do |value|
                    if example[i] == value
                        x << 1.0
                    else
                        x << 0.0
                    end
                end
            end

        end

        return x
    end

    #def normalize(examples, attributes)
    #   V attributes.each_with_index do |attribute, i|
    #        examples.each

    #    end
    #end
end

class Tester
    @@random_seed = 0
    @@test_ratio = 10
    def initialize(data_file, attr_file)
        raw_attributes = Attribute.parse_attr_file(attr_file)

        @examples = LearningData.parse_data_file(data_file, raw_attributes.length)
        @attributes = Attribute.calculate_attributes(@examples, raw_attributes)

        #@examples.shuffle!(random: Random.new(@@random_seed))

        ann = ANN.new(@examples, @attributes)
    end
end

tester = Tester.new(data_file_name, attr_file_name)
#tester.cross_validation

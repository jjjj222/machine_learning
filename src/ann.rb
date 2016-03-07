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
        examples = LearningData.ann_normalize(examples, attributes)

        examples.map! do |example|
            map_to_input(example, attributes)
        end



        if (attributes[-1].continuous?)
            puts "TODO: if (attributes[-1].continuous?)"
            exit
        end



        @width_of_output = attributes[-1].values.length
        @width_of_input = examples[0].length - @width_of_output
        @width_of_hidden_layer = attributes.size - 1
        @num_of_hidden_layer = 1

        @x = initialize_node()
        @sigma = initialize_node()
        @w = initialize_edge(@x)

        (0...1000).each do |qq|
            output = examples[0][@width_of_input..-1]
            res = forward_propagate(@x, examples[0][0...@width_of_input])
            #puts "#{output} #{res}"

            calculate_sigma(res, output)
            back_propagation(@w, @x, @sigma)
        end
        output = examples[0][@width_of_input..-1]
        res = forward_propagate(@x, examples[0][0...@width_of_input])
        puts "#{output} #{res}"
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

    def initialize_node
        x = []

        x << [0.0] * @width_of_input
        #(0...@num_of_hidden_layer).each do |i|
        @num_of_hidden_layer.times do
            x << [0.0] * @width_of_hidden_layer
        end
        x << [0.0] * @width_of_output

        return x
    end

    def initialize_edge(nodes)
        w = []
        nodes.each_with_index do |nodes_row, i|
            w_row = []
            nodes_row.length.times do
                w_row << (i == 0 ? [] : ([0.0] * (nodes[i-1].length + 1)))
            end
            w << w_row
        end
        return w
    end

    def map_to_input(example, attributes)
        res = []

        attributes.each_with_index do |attribute, i|
            if attribute.continuous?
                res << example[i]
            else
                attribute.values.each do |value|
                    res << (example[i] == value ? 1.0 : 0.0) 
                end
            end
        end

        return res
    end
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

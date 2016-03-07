#!/usr/bin/ruby

require "./src/data.rb"

#------------------------------------------------------------------------------
#   
#------------------------------------------------------------------------------
if ARGV.length == 1
    $num_of_iteration = ARGV[0].to_i
else
    $num_of_iteration = 100
end

#data_file_name = ARGV[0]
#attr_file_name = ARGV[1]
#------------------------------------------------------------------------------
#   
#------------------------------------------------------------------------------
#case_name = "iris"
case_name = "example2"
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

        #examples = [examples[0]]
        #examples = examples[0..3]

        @width_of_output = attributes[-1].values.length
        @width_of_input = examples[0].length - @width_of_output
        @width_of_hidden_layer = attributes.size - 1
        @num_of_hidden_layer = 1
        #@update_ratio = 0.1
        @update_ratio = 0.1

        @x = initialize_node()
        @sigma = initialize_node()
        @w = initialize_edge(@x)

        min_error = 10000.0
        #(0...1000000).each do |qq|
        #(0...100).each do |qq|
        (0...$num_of_iteration).each do |qq|
            #examples.each do |example|
            #    input, output = example.split_at(@width_of_input)
            #    forward_propagate(input)
            #    back_propagation(output)
            #end
            examples.each_with_index do |example, i|
                input, output = example.split_at(@width_of_input)
                res = forward_propagate(input)
                back_propagation(output)
                #print "#{i} : "
                #puts "#{output} #{res}"
            end

            error = calculate_all_error(examples)

            if min_error > error
                min_error = error
                puts "#{qq} #{min_error}"
            else
            end
        end

        examples.each_with_index do |example, i|
            input, output = example.split_at(@width_of_input)
            #print example; puts
            res = forward_propagate(input)
            puts "#{i} : #{output} #{res}"
        end
        error = calculate_all_error(examples)
        puts "#{error}"


        #error = calculate_all_error(examples)
        ##error = calculate_error(examples[0])
        #puts "#{error}"


        #output = examples[0][@width_of_input..-1]
        ##res = forward_propagate(@x, examples[0][0...@width_of_input])
        ##forward_propagate(@x, examples[0][0...@width_of_input])
        #forward_propagate(examples[0][0...@width_of_input])
        #res = @x[-1]
        #error = calculate_error(examples[0])
        #puts "#{output} #{res} #{error}"
    end

    def calculate_all_error(examples)
        examples.inject(0.0) do |sum, example|
            sum += calculate_error(example)
        end
    end

    def calculate_error(example)
        input, output = example.split_at(@width_of_input)
        res = forward_propagate(input)

        sum = 0.0
        output.each_with_index do |output_i, i|
            sum += (res[i] - output_i) ** 2
        end

        return sum / 2
    end

    def calculate_sigma(output)
        res = @x[-1]
        @sigma[-1].each_index do |i|
            @sigma[-1][i] = res[i] * (1.0 - res[i]) * (output[i] - res[i])
        end

        #@sigma[1...-1].reverse_each_with_index do |sigma_row, i|
        #    sigma_row.each_index do |j|
        #        sum = 0.0
        #        @w[i+1].each_with_index do |w_elt, k|
        #            sum += (w_elt[j] * @sigma[i+1][k])
        #        end
        #        @sigma[i][j] = @x[i][j] * (1.0 - @x[i][j]) * sum
        #        #puts "#{i} #{j} = #{@x[i][j]} #{sum} #{@sigma[i][j]}"
        #    end
        #end

        @sigma.reverse_each_with_index do |sigma_row, i|
            if i == 0 or i == @sigma.length - 1
                next
            end

            sigma_row.each_index do |j|
                sum = 0.0
                @w[i+1].each_with_index do |w_elt, k|
                    sum += (w_elt[j] * @sigma[i+1][k])
                end
                @sigma[i][j] = @x[i][j] * (1.0 - @x[i][j]) * sum
                #puts "#{i} #{j} = #{@x[i][j]} #{sum} #{@sigma[i][j]}"
            end
        end
    end

    def back_propagation(output)
        calculate_sigma(output)

        @w.each_index do |i|
            if i == 0
                next
            end

            x_row_with_1 = @x[i-1] + [1.0]

            @w[i].each_index do |j|
                @w[i][j].each_index do |k|
                    @w[i][j][k] += @update_ratio * @sigma[i][j] * x_row_with_1[k]
                end
            end
        end
    end

    def forward_propagate(example)
        @x.each_with_index do |x_row, i|
            if (i == 0)
                @x[i] = example
            else
                x_row.each_with_index do |x_cell, j|
                    @x[i][j] = Math.sigmoid((@x[i-1] + [1.0]).inner_product(@w[i][j]))
                end
            end
        end

        return @x[-1]
    end

    def initialize_node
        x = []

        x << [0.0] * @width_of_input
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
                #w_row << (i == 0 ? [] : ([0.1] * (nodes[i-1].length + 1)))
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

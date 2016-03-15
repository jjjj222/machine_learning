require 'json'

require "./src/data.rb"
require "./src/tester.rb"
require "./src/majority.rb"
require "./src/id3.rb"

#------------------------------------------------------------------------------
#   
#------------------------------------------------------------------------------
class ANN
    @@random_seed = 0
    @@partition_ratio = 3
    #@@partition_ratio = 5

    def initialize(examples, attributes, setup)
        @attributes = attributes

        examples.shuffle!(random: Random.new(@@random_seed))

        #normalized_examples = ann_normalize(examples, attributes)

        #mapped_examples = normalized_examples.map do |example|
        mapped_examples = examples.map do |example|
            #map_to_ann(example, attributes)
            map_to_ann(example)
        end
        #mapped_examples.dump
        #exit

        if (attributes[-1].continuous?)
            puts "TODO: if (attributes[-1].continuous?)"
            exit
        end

        training_examples, validation_examples =
            mapped_examples.split_by_ratio(@@partition_ratio)


        @width_of_output = attributes[-1].values.length
        @width_of_input = training_examples[0].length - @width_of_output
        @width_of_hidden_layer = attributes.size - 1
        @num_of_hidden_layer = 1
        @update_ratio = 0.1
        @num_of_iteration = 100

        @x = initialize_node()
        @sigma = initialize_node()
        @w = initialize_edge(@x)

        best_i = 0
        min_error = 1000000.0
        best_w = @w.deep_dup

        (1..@num_of_iteration).each do |i|
            #examples.each do |example|
            training_examples.each do |example|
                input, output = example.split_at(@width_of_input)
                forward_propagate(input)
                back_propagation(output)
            end

            #error = calculate_all_error(examples)
            #error = calculate_all_error(training_examples)
            error = calculate_all_error(validation_examples)

            if (i % 10000 == 0)
                #puts "#{i}"
            end

            if min_error > error
                min_error = error
                best_i = i
                best_w = @w.deep_dup
                #puts "#{i}/#{$num_of_iteration} #{min_error}"
            end

            if (i > 100000 && i > 2 * best_i)
            #if (i > 2 * best_i)
                break
            end
        end

        #validation_examples.each_with_index do |example, i|
        #    input, output = example.split_at(@width_of_input)
        #    res = forward_propagate(input)
        #    puts "#{i} : #{output} #{res}"
        #end

        #puts
        #puts "best #{best_i} : #{min_error}"
        #best_w.dump
        #puts

        #@w.dump
        #@dup_w = @w.deep_dup
        #@dup_w[0][0][0] = "QQ"
        #@dup_w[1][1][1] = "XD"
        #@dup_w.dump


        #error = calculate_all_error(examples)
        #puts "#{error}"
        #@x.dump
        #@sigma.dump
        #@w.dump

        #hash = Hash.new
        #hash["case_name"] = $CASE_NAME
        #hash["i"] = best_i
        #hash["error"] = min_error
        #hash["w"] = best_w

        #File.open($DUMP_FILE_NAME, "w") do |f|
        #    #f.write(best_w.to_json)
        #    f.write(hash.to_json)
        #end

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

    def map_to_ann(example)
        res = []

        @attributes.each_with_index do |attribute, i|
            if (example[i] == "?")
                if attribute.continuous?
                    res << attribute.mean
                else
                    value = 1.0 / attribute.values.length
                    res += [value] * attribute.values.length
                end
            else
                if attribute.continuous?
                    res << (example[i].to_f - attribute.mean) / attribute.se
                else
                    attribute.values.each do |value|
                        res << (example[i] == value ? 1.0 : 0.0)
                    end
                end
            end
        end

        return res
    end

    #def ann_normalize(examples, attributes)
    #    examples_column = examples.transpose

    #    attributes.each_with_index do |attribute, i|
    #        if attribute.continuous?
    #            #examples_column[i].fix_unknown!(attribute.mean)

    #            #examples_column[i].map! {|elt| elt.to_f}
    #            #examples_column[i].normalize!
    #            #examples_column[i].normalize_by!(attribute.mean, attribute.se)
    #        else
    #            #examples_column[i].fix_unknown!
    #        end
    #    end

    #    return examples_column.transpose
    #end
    #def add_record(record)
    #    record["QQ"] = 1
    #end

    def classify(example)
        mapped_example = map_to_ann(example)

        input, output = mapped_example.split_at(@width_of_input)
        #input.dump
        #output.dump
        res = forward_propagate(input)

        if (@attributes[-1].continuous?)
            # TODO
        else
            index = res.index(res.max)
            return @attributes[-1].values[index]
        end
    end
end

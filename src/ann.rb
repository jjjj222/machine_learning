#!/usr/bin/ruby

require "./src/data.rb"
#------------------------------------------------------------------------------
#   
#------------------------------------------------------------------------------
data_file_name = "./data/iris/iris.data"
attr_file_name = "./data/iris/iris.attribute"

class Tester
    @@random_seed = 0
    @@test_ratio = 10
    def initialize(data_file, attr_file)
        raw_attributes = Attribute.parse_attr_file(attr_file)

        @examples = LearningData.parse_data_file(data_file, raw_attributes.length)
        @attributes = Attribute.calculate_attributes(@examples, raw_attributes)

        @examples.shuffle!(random: Random.new(@@random_seed))

        #@examples.dump
        @attributes.dump

        #@example_partition = Array.new(@@test_ratio) { Array.new }
        #@examples.each_slice(@@test_ratio) do |n_examples|
        #    n_examples.each_with_index do |example, i|
        #        @example_partition[i] << example
        #    end
        #end
    end

    #def test_1
    #    num_of_learning_example = @examples.length - @examples.length / @@test_ratio
    #    learning_examples = @examples[0...num_of_learning_example]
    #    test_examples = @examples[num_of_learning_example..-1]


    #    id3 = ID3.new(learning_examples, @attributes)
    #    id3.dump_tree
    #    id3.prune
    #    id3.dump_tree
    #end

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
end

tester = Tester.new(data_file_name, attr_file_name)
#tester.cross_validation

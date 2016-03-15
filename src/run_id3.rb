#!/usr/bin/ruby

require "./src/data.rb"
require "./src/util.rb"
require "./src/statistics.rb"
require "./src/id3.rb"
require "./src/majority.rb"
require "./src/print.rb"
require "./src/tester.rb"

#puts __FILE__
#puts "#{FILE_DIR}"

#------------------------------------------------------------------------------
#   args
#------------------------------------------------------------------------------
if ARGV.length != 2
    puts "usage: id3.rb <data_file> <attribute_file>"
    exit
end

#if ARGV[0]  == "-t"
#    data_file_name = "./data/#{ARGV[1]}/#{ARGV[1]}.data"
#    attr_file_name = "./data/#{ARGV[1]}/#{ARGV[1]}.attribute"
#else
#    data_file_name = ARGV[0]
#    attr_file_name = ARGV[1]
#end

data_file_name = ARGV[0]
attr_file_name = ARGV[1]

#if !File.readable? data_file_name
#    puts "Error: Can't open data file \"#{data_file_name}\" !!"
#    #exit
#end
#
#if !File.readable? attr_file_name
#    puts "Error: Can't open attribute file \"#{attr_file_name}\" !!"
#    #exit
#end


#------------------------------------------------------------------------------
#   
#------------------------------------------------------------------------------
class ID3Tester < Tester
    #@@random_seed = 0
    #@@test_ratio = 10
    #def initialize(data_file, attr_file)
    #    raw_attributes = Attribute.parse_attr_file(attr_file)
    #    @examples = LearningData.parse_data_file(data_file, raw_attributes.length)

    #    @attributes = Attribute.calculate_attributes(@examples, raw_attributes)
    #    @examples.shuffle!(random: Random.new(@@random_seed))

    #    @example_partition = @examples.partition_n_parts(@@test_ratio)
    #end

    #def test_1
    #    num_of_learning_example = @examples.length - @examples.length / @@test_ratio
    #    learning_examples = @examples[0...num_of_learning_example]
    #    test_examples = @examples[num_of_learning_example..-1]


    #    id3 = ID3.new(learning_examples, @attributes)
    #    id3.dump_tree
    #    id3.prune
    #    id3.dump_tree
    #end

    def cross_validation_id3
        printer = Printer.new(80)
        all_recorder = []
        @setup = Hash.new
        @setup["prune"] = false
        #i = 0
        (0...@@num_of_round).each do |i|
            #recorder = Recorder.new(i+1)
            recorder = []
            printer.draw_box "round #{i+1}", "="
            recorder << i+1

            #learning_examples = get_learning_examples(i)
            learning_examples = @examples_partition.merge_all_but(i)
            test_examples = @examples_partition[i]
            #puts "# of learning examples = #{learning_examples.length}"
            #recorder << learning_examples.length
            #puts "# of test examples = #{test_examples.length}"
            #recorder <<

            #puts ">>> before pruning:"
            id3 = ID3.new(learning_examples, @attributes, @setup)
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
            #majority_classifier = Majority.new(learning_examples)
            majority_classifier = Majority.new(learning_examples, @attributes)
            #no_of_error = majority_classifier.test(test_examples)
            no_of_error = test_all(majority_classifier, test_examples)
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

        #return get_print_format(avg)
        return avg.round(1)
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
        avg, se = data.mean_se

        tNv = 2.23
        interval_low = avg - se * tNv
        interval_low = 0.0 if interval_low < 0.0
        #puts interval_low
        interval_up = avg + se * tNv
        interval_up = 100.0 if interval_up > 100.0
        #puts interval_up
        #interval = "(#{get_print_format(interval_low)}, #{get_print_format(interval_up)})"
        interval = "(#{interval_low.round(1)}, #{interval_up.round(1)})"
        #puts interval
        #return [get_print_format(avg), get_print_format(se), interval]
        return [avg.round(1), se.round(1), interval]
    end

    #def get_print_format(data)
    #    #return sprintf("%0.02f", data)
    #    return data.round(1)
    #end
end

#------------------------------------------------------------------------------
#   
#------------------------------------------------------------------------------
id3_tester = ID3Tester.new(data_file_name, attr_file_name)
id3_tester.cross_validation_id3

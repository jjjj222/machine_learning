#!/usr/bin/ruby

require 'json'

require "./src/data.rb"
require "./src/tester.rb"
require "./src/majority.rb"
require "./src/id3.rb"
require "./src/ann.rb"

#lines = IO.readlines("tmp/ann.json")
##lines.dump
##puts lines
#parsed = JSON.parse(lines[0])
##parsed.dump
##puts parsed.is_a? Array
#puts parsed
#
##$
#$START_TIME = Time.now.strftime "%Y%m%d_%H%M%S"
#$DUMP_FILE_NAME = "./tmp/ann_#{$START_TIME}.json"
#exit

#------------------------------------------------------------------------------
#   
#------------------------------------------------------------------------------
#if ARGV.length == 1
#    $num_of_iteration = ARGV[0].to_i
#else
#    #$num_of_iteration = 1000
#    $num_of_iteration = 100
#end

#data_file_name = ARGV[0]
#attr_file_name = ARGV[1]
#------------------------------------------------------------------------------
#   
#------------------------------------------------------------------------------
#$CASE_NAME = "iris"
#$CASE_NAME = "example2"
#case_name = "example2"
case_name = "iris"
file_base_name = "./data/#{case_name}/#{case_name}"
data_file_name = "#{file_base_name}.data"
attr_file_name = "#{file_base_name}.attribute"


class ANNTester < Tester
    def cross_validation_ann
        i = 0
        learning_examples = @examples_partition.merge_all_but(i)
        test_examples = @examples_partition[i]

        #ann = ANN.new(@examples, @attributes)
        ann = ANN.new(learning_examples, @attributes)

        test_examples.each do |example|
            puts "#{ann.classify(example)} #{example[-1]}"
        end
    end
end

#tester = ANNTester.new(data_file_name, attr_file_name)
#tester.cross_validation_ann
tester = Tester.new(data_file_name, attr_file_name)
record = tester.single_run(ANN)
puts record
#record.dump
#tester.single_run(ANN)
#tester.cross_validation(ID3)
#tester.cross_validation(Majority)



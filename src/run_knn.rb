#!/usr/bin/ruby

require "./src/tester.rb"
require "./src/knn.rb"

#------------------------------------------------------------------------------
#   
#------------------------------------------------------------------------------
if ARGV.length != 3
    if ARGV.length == 2 and ARGV[0] == "-t"
        case_name = ARGV[1]
    else
        puts "usage: run_ann.rb <data_file> <attribute_file> <setup_file>"
        exit
    end
end

if case_name != nil
    file_base_name = "./data/#{case_name}/#{case_name}"
    data_file_name = "#{file_base_name}.data"
    attr_file_name = "#{file_base_name}.attribute"
    setup_file_name = "#{file_base_name}.setup.knn"
else
    data_file_name = ARGV[0]
    attr_file_name = ARGV[1]
    setup_file_name = ARGV[2]
end

#------------------------------------------------------------------------------
#   
#------------------------------------------------------------------------------
tester = Tester.new(data_file_name, attr_file_name, setup_file_name)
#record = tester.single_run(KNN)
#record.dump
#exit
all_record = tester.cross_validation(KNN)
#all_record.dump
##record = tester.single_run(ANN)
##puts record
##record.dump
##puts record

printer = Printer.new(80)
printer.draw_box("setup", "#")
tester.print_setup

printer.draw_box("summary", "#")
printer.draw_hash_table(all_record)

printer.draw_box "statistics", "#"
accuracy = all_record.map do |hash|
    ( 1.0 - (hash["error"].to_f / hash["test"]) ) * 100
end

#i = all_record.inject(0.0) do |sum, hash|
#    sum += hash["i"]
#end / all_record.length

headers = ["", "accuracy", "SE", "95% CI"]
data = ["knn"]
data += accuracy.avg_se_ci_95(2.23)
#headers.dump
#data.dump
printer.draw_table([data], [headers])

#id3_record = tester.cross_validation(ID3)
#id3_record.dump

#majority_record = tester.cross_validation(Majority)
#majority_record.dump
#

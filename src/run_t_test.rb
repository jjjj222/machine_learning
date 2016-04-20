#!/usr/bin/ruby

require "./src/util.rb"
require "./src/statistics.rb"

if ARGV.length != 2
    puts "usage: run_t_test.rb <data 1> <data 2>"
    exit
end

all_data = []
(0...ARGV.length).each do |i|
    all_data[i] = IO.parse_tmp(ARGV[i])
end

#------------------------------------------------------------------------------
#   check
#------------------------------------------------------------------------------
total_round = all_data[0].length

all_data.each_with_index do |data, i|
    if data.length != total_round
        puts "round not match"
        exit
    end

    data.each_with_index do |tuple, j|
        if tuple.length != 3
            puts "tuple not match"
            exit
        end

        if tuple[1].to_i != all_data[0][j][1].to_i
            puts "test not match"
            exit
        end
    end
end

#------------------------------------------------------------------------------
#   
#------------------------------------------------------------------------------
all_data = all_data.map do |data|
    data.map do |tuple|
        (1.0 - (tuple[2].to_f / tuple[1].to_f)) * 100
    end
end

#all_data.dump
#all_data = all_data.map do |data|
#    data.avg_se_ci_95(2.23)
#end
#all_data.dump
#------------------------------------------------------------------------------
#   
#------------------------------------------------------------------------------
diff = []

(0...total_round).each do |i|
    diff << all_data[0][i] - all_data[1][i]
end
#diff.dump
#print diff.avg_se_ci_95(2.23, false)
print diff.avg_se_ci_95(2.23)
puts




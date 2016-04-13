#!/usr/bin/ruby

require './src/util.rb'

#data = IO.parse_data(ARGV[0])
data = IO.parse_tmp(ARGV[0])

data = data.map do |line|
    line[2..-1]
end

data.dump_data

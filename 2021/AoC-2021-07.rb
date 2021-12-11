#!/usr/bin/env ruby

# https://adventofcode.com/2021/day/7

data = open('./input-07.txt').readlines(chomp: true).first.split(',').map(&:to_i).sort

#part 1

med = data[data.length/2]
puts data.map{|v| (v-med).abs}.sum

# part2
  
p (data.first..data.last).map{|v| data.map{|x| (((x-v)**2+(x-v).abs)/2)}.sum}.min
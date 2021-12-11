#!/usr/bin/env ruby

#https://adventofcode.com/2021/day/1

data = open('./2021/input-01.txt').each_line.map(&:to_i)

# part 1

puts data.each_cons(2).map{|a,b|b-a}.filter(&:positive?).count

# part 2

puts data.each_cons(3).map(&:sum).each_cons(2).
          map{|a,b|b-a}.filter(&:positive?).count
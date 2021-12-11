#!/usr/bin/env ruby

#https://adventofcode.com/2020/day/1

#Dir.chdir(ENV["TM_DIRECTORY"]) if ENV["TM_DIRECTORY"]


PRODUCTION = true #&& false
source = PRODUCTION ? open('./input-01.txt') : DATA

data = source.readlines(chomp:true).map(&:to_i)

#part 1
p data.combination(2).filter{|a| a.sum == 2020}.first.inject(&:*)
p data.combination(3).filter{|a| a.sum == 2020}.first.inject(&:*)

__END__
1721
979
366
299
675
1456
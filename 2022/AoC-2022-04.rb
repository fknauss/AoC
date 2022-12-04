#!/usr/bin/env ruby

# https://adventofcode.com/2022/day/4

PRODUCTION = true #&& false
source = PRODUCTION ? open('AoC-2022-04.txt') : DATA
#fetch and format
data = source.readlines(chomp: true).
      map{_1.split(/[-,]/).map(&:to_i)}.
      map{[_1.._2,_3.._4]}

# part 1
p data.map{|(a,b)| a.cover?(b)||b.cover?(a) }.count(true)

# part 2
p data.map{|(a,b)|a.max>=b.min && b.max>=a.min}.count(true)

__END__
2-4,6-8
2-3,4-5
5-7,7-9
2-8,3-7
6-6,4-6
2-6,4-8
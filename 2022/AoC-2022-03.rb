#!/usr/bin/env ruby

# https://adventofcode.com/2022/day/3

PRODUCTION = true #&& false
source = PRODUCTION ? open('./AoC-2022-03.txt') : DATA
# get rid of extraneous space in input
data = source.readlines(chomp: true).map(&:chars)

VAL=['',*'a'..'z',*'A'..'Z'].each_with_index.to_h

# part 1
p data.map{_1.each_slice(_1.size/2)}.map{VAL[*_1.inject(&:&)]}.sum
  
# part 2
p data.each_slice(3).map{VAL[*_1.inject(&:&)]}.sum

__END__
vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw
#!/usr/bin/env ruby

# https://adventofcode.com/2022/day/8

PRODUCTION = true #&& false
source = PRODUCTION ? open('AoC-2022-08.txt') : DATA
#fetch and format
data = source.readlines(chomp: true).map{_1.chars.map(&:to_i)}

def pzip(d)
  d.map{|r| yield r}.flatten.zip(
  d.map{|r| (yield r.reverse).reverse}.flatten,
  d.transpose.map{|r| yield r}.transpose.flatten,
  d.reverse.transpose.map{|r| yield r}.transpose.reverse.flatten)
end

#part 1
p pzip(data){|r| a=-1; r.map{b,a=a,[a,_1].max;_1>b}}.
            map{_1.inject(&:|)}.select{_1}.count

#part 2
p pzip(data){|r| (0...r.size).map{|s|r.drop(s+1).
                              chunk_while{_1<r[s]}.first&.size||0}}.
            map{_1.inject(&:*)}.max

__END__
30373
25512
65332
33549
35390
#!/usr/bin/env ruby

# https://adventofcode.com/2022/day/8

PRODUCTION = true #&& false
source = PRODUCTION ? open('AoC-2022-08.txt') : DATA
#fetch and format
data = source.readlines(chomp: true).map{_1.chars.map(&:to_i)}

def pzip(d)
  sees(d).flatten.zip(
  sees(d.map(&:reverse)).map(&:reverse).flatten,
  sees(d.transpose).transpose.flatten,
  sees(d.reverse.transpose).transpose.reverse.flatten
  )
end

#part 1
def sees(d)
  d.map{|r| a=-1; r.map{b,a=a,[a,_1].max;b}.zip(r).map{|(x,y)|y>x}}
end

p pzip(data).map{_1.inject(&:|)}.select{_1}.count

#part 2
def sees(d) # total hack
  d.map{|r| (0...r.size).map{|s|r.drop(s+1).chunk_while{_1<r[s]}.first&.size||0}}
end
p pzip(data).map{_1.inject(&:*)}.max

__END__
30373
25512
65332
33549
35390
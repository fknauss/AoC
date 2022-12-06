#!/usr/bin/env ruby

# https://adventofcode.com/2022/day/1

PRODUCTION = true #&& false
source = PRODUCTION ? open('./AoC-2022-01.txt') : DATA
data = source.readlines(chomp: true).
          slice_after(&:empty?).
          map{|a| a.reject(&:empty?).map(&:to_i)}

# part 1
p data.map(&:sum).max

# part 2
p data.map(&:sum).max(3).sum


__END__
1000
2000
3000

4000

5000
6000

7000
8000
9000

10000

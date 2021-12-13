#!/usr/bin/env ruby

#https://adventofcode.com/2020/day/05

PRODUCTION = true #&& false
source = PRODUCTION ? open('./input-05.txt') : DATA

data=source.readlines(chomp: true)
data.map!{|s| s.tr("FBLR","0101").to_i(2)}
# part 1
puts data.max
# part 2
data.sort!
puts ((data.min..data.max).to_a-data).first
__END__
FBFBBFFRLR
BFFFBBFRRR
FFFBBBFRRR
BBFFBBFRLL

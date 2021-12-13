#!/usr/bin/env ruby

#https://adventofcode.com/2020/day/6

PRODUCTION = true #&& false
source = PRODUCTION ? open('./input-06.txt') : DATA

data=source.readlines().join("").split(/\n\n/)

# part 1
p data.map{|s| s.delete("\n").each_char.uniq.join.length}.sum

# part 2

p data.map{|s| ("a".."z").to_a.intersection(*(s.split("\n").map{|s|s.each_char.to_a})).length}.sum

__END__
abc

a
b
c

ab
ac

a
a
a
a

b

#!/usr/bin/env ruby

#https://adventofcode.com/2020/day/9

PRE_LEN = 25
PRODUCTION = (PRE_LEN == 25)
source = PRODUCTION ? open('./input-09.txt') : DATA

data = source.readlines().map(&:to_i)
# part 1

goal = data.each_cons(PRE_LEN+1) do |a|
  n = a.pop
  break n if a.filter{|v| (v*2 != n) && a.include?(n-v)}.length == 0
end

p goal

# part 2

gsum = data.inject([]) do |c,v|
  c << v
  while (c.sum > goal) do
    c.shift
  end
  break c if c.sum == goal
  c
end
p gsum.min+gsum.max
Í
__END__
35
20
15
25
47
40
62
55
65
95
102
117
150
182
127
219
299
277
309
576

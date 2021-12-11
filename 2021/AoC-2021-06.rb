#!/usr/bin/env ruby

# https://adventofcode.com/2021/day/6

data = open('./2021/input-06.txt').readlines(chomp: true).first.split(',').map(&:to_i).tally

datat = '3,4,3,1,2'.split(',').map(&:to_i).tally

hist = [0]*9
data.keys.each{|k| hist[k]=data[k]}


def day(a)
  n=a.shift
  a[6]+=n
  a.push(n)
end

80.times { hist=day(hist)}
p hist.sum

#part 2

(256-80).times { hist=day(hist)}

p hist.sum
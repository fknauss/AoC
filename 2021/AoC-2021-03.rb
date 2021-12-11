#!/usr/bin/env ruby

# https://adventofcode.com/2021/day/

data = open('./2021/input-03.txt').each_line
3
# part 1

ch=data.map{|s| s.chomp.split('').map(&:to_i)}
#p ch[0]
l = ch.length
n = ch.transpose.map(&:sum).map{|v| v*2>=l ? 1:0}
#p n
v = n.inject{|c,v|c*2+v}
puts v*(2**ch[0].length-1-v)

# part 2

def filt(d,n=0, &b)
  return d if d.length==1
  return d if n>=d[0].length
  c= yield(d.map{|v| v[n]}.sum*2,d.length) ? 1:0
  filt(d.filter{|v|v[n]==c},n+1, &b )
end

p filt(ch){|a,b| a>=b}.first.inject{|c,v|c*2+v}*
      filt(ch){|a,b| a<b}.first.inject{|c,v|c*2+v}
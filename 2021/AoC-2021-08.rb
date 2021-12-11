#!/usr/bin/env ruby

# https://adventofcode.com/2021/day/8

class String
  def has?(s)
    s.each_char.inject(true){|c,v| c && self.include?(v)}
  end
  def order
    self.each_char.sort.join
  end
end

data = open('./input-08.txt').each_line.
                              map{|a| a.split('|')}.
                              map{|a,b| [a.split.map(&:order),b.split.map(&:order)]}

def digits(s)
  dig = [nil]*10
  dig[1] = s.filter{|s| s.length == 2}.first
  dig[7] = s.filter{|s| s.length == 3}.first
  dig[4] = s.filter{|s| s.length == 4}.first
  dig[8] = s.filter{|s| s.length == 7}.first
  dig[9] = s.filter{|s| s.length == 6 && s.has?(dig[4])}.first
  dig[0] = s.filter{|s| s.length == 6 && !s.has?(dig[4]) && s.has?(dig[1])}.first
  dig[6] = s.filter{|s| s.length == 6 && !s.has?(dig[4]) && !s.has?(dig[1])}.first
  dig[5] = s.filter{|s| s.length == 5 && dig[6].has?(s)}.first
  dig[3] = s.filter{|s| s.length == 5 && s.has?(dig[7])}.first
  dig[2] = (s-dig).first
  
  dig
end
#part 1

s= data.inject(0) do |c,v|
  d = digits(v[0])
  n = v[1].map{|x| d.index(x)}
  [1,4,7,8].inject(c){|c,v| c+n.count(v)}
end

p s

#part 2
s= data.map do |v|
  d = digits(v[0])
  n = v[1].map{|x| d.index(x)}
  n.map(&:to_s).join.to_i
end

p s.sum
#!/usr/bin/env ruby --version

#https://adventofcode.com/2021/day/5

Point = Struct.new(:x,:y)
class Numeric
  def between?(a,b) = self <= [a,b].max && self >= [a,b].min
end


data = open('./input-05.txt').each_line.
    map{|s| s.scan(/\d+/).map(&:to_i).each_slice(2).map{|v| Point[*v]}}
    

# part 1
      
def rng(a,b) = (0..(b-a).abs).each.map{|i| ((b-a).positive? ? 1: -1)*i+a}
    
vert = data.filter{|a| a[0].x == a[1].x}.
            map{|a| rng(a[0].y,a[1].y).map{|y| Point[a[0].x,y]}}
            
horiz = data.filter{|a| a[0].y == a[1].y}.
            map{|a| rng(a[0].x,a[1].x).map{|x| Point[x,a[0].y]}}


p (vert + horiz).combination(2).map{|a,b| a & b}.flatten.uniq.length

# part 2

diag = data.filter{|a|  a[0].x != a[1].x && a[0].y != a[1].y}.
            map{|a| rng(a[0].x,a[1].x).zip(rng(a[0].y,a[1].y)).map{|x,y| Point[x,y]}}

p (vert + horiz + diag).combination(2).map{|a,b| a & b}.flatten.uniq.length

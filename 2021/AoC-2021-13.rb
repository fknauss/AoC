#!/usr/bin/env ruby

# https://adventofcode.com/2021/day/13

Point= Struct.new(:x, :y)

PRODUCTION = true #&& false
source = PRODUCTION ? open('./input-13.txt') : DATA
data=source.readlines(chomp:true)

points = data.take_while{|s| !s.empty?}.
            map{|x| Point.new(*x.split(",").map(&:to_i))}

instructions = data.drop_while{|s| !s.empty?}.drop(1).map do |s|
  s.scan(/([xy])=(\d+)/).map{|x| [x[0],x[1].to_i]}.first
end

def fold(pt,i)
  if i[0]=="x"
    return Point[2*i[1]-pt.x,pt.y] if pt.x>i[1]
  elsif i[0]=="y"
    return Point[pt.x,2*i[1]-pt.y] if pt.y>i[1]
  end
  pt
end

#part 1
puts points.map{|pt| fold(pt,instructions.first)}.uniq.length

#part2

fp = instructions.inject(points){|pl,i| pl.map{|pt| fold(pt,i)}}
width = instructions.filter{|x| x[0]=='x'}.map{|x| x[1]}.min
height = instructions.filter{|x| x[0]=='y'}.map{|x| x[1]}.min
code = height.times.map do |y|
  width.times.map{|x| fp.include?(Point[x,y]) ? "#" : " "}.join
end
puts code

__END__
6,10
0,14
9,10
0,3
10,4
4,11
6,0
6,12
4,1
0,13
10,12
3,4
3,0
8,4
1,10
2,14
8,10
9,0

fold along y=7
fold along x=5

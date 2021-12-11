#!/usr/bin/env ruby

# https://adventofcode.com/2021/day/11

PRODUCTION = true #&& false
source = PRODUCTION ? open('./input-11.txt') : DATA

levels = source.readlines(chomp:true).map{|l| l.each_char.map(&:to_i)}

require "./point"

class Oct
  attr_accessor :flashes, :days
  def initialize(l)
    @level = l
    b=Point[l.first.length,l.length]
    Point.bound(b)
    @area = b.x*b.y
    @flashes = 0
    @delta = 0
    @days = 0
  end
    
  def nines =  Point::all.filter{|c| get(c)>9}
  def get(p) = @level[p.y][p.x]
  def inc(p) = @level[p.y][p.x]+=1
  def reset(p) = @level[p.y][p.x]=0

    
  def day
    of = @flashes
    @days +=1
    Point::all.each{|c| inc(c)}
    while((n=nines).length>0)
      n.each do |c|
        reset(c)
        @flashes +=1
        c.vn8.each{|c| inc(c) if get(c)>0}
      end
    end
    @delta = @flashes -of
    self
  end
      
  def to_s
    @level.map{|l| l.map(&:to_s).join}.join("\n")
  end
  
  def done?
    @delta == @area
  end
  
end

# part 1
oct = Oct.new(levels)
100.times {oct.day}
p oct.flashes

#part 2
oct.day until oct.done? 
p oct.days
  


__END__
5483143223
2745854711
5264556173
6141336146
6357385478
4167524645
2176841721
6882881134
4846848554
5283751526
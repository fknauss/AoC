#!/usr/bin/env ruby

#https://adventofcode.com/2020/day/11

PRODUCTION = true # && false
source = PRODUCTION ? open('./input-11.txt') : DATA

require "../point"

legend={empty: "L", full: "#", floor:"."}

data = source.readlines(chomp: true).map do |l|
  l.each_char.map{|c| legend.invert[c]}
end
class Grid
  attr_accessor :curr, :changed
  def initialize (l)
    Point::bound(Point[l.first.length,l.length])
    @init = Hash[Point::all.map{|pt| [pt, l[pt.y][pt.x]]}]
    @curr = @init
    @changed = true
  end
  
  def reset
    @curr = @init
  end
  def seats
    @curr.values.count(:full)
  end
  
  def step
    nm = {}
    Point::all.each do |pt|
      if @curr[pt]== :empty && pt.vn8.map{|pt|@curr[pt]}.count(:full)==0
        nm[pt]= :full
      elsif @curr[pt]== :full && pt.vn8.map{|pt|@curr[pt]}.count(:full)>=4
        nm[pt]= :empty
      else
        nm[pt] = @curr[pt]
      end
    end
    @changed = (nm != @curr)
    @curr = nm
  end
end

grid = Grid.new(data)
grid.step while grid.changed
p grid.seats

__END__
L.LL.LL.LL
LLLLLLL.LL
L.L.L..L..
LLLL.LL.LL
L.LL.LL.LL
L.LLLLL.LL
..L.L.....
LLLLLLLLLL
L.LLLLLL.L
L.LLLLL.LL
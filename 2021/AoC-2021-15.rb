#!/usr/bin/env ruby

# https://adventofcode.com/2021/day/15

require '../point'
require 'set'

PRODUCTION = true #&& false
source = PRODUCTION ? open('./input-15.txt') : DATA

data=source.readlines(chomp:true).map{|s| s.each_char.map(&:to_i)}

class Pathfind
  def initialize(mp)
    @mp = mp
    @bound = Point[mp.first.length,mp.length]
    Point::bound(@bound)
    @edges = {Point.new(0,0) => 0}
    @done = Set[]
  end
  def val(pt)
    @mp[pt.y][pt.x]
  end

  def process
    until @edges.each_key.include?(@bound+Point[-1,-1])
      nxt = @edges.each_key.reject{|s| @done.include?(s)}.min_by{|pt|@edges[pt]}
      #puts  @done.length.to_s + " - " + nxt.to_s
      nxt.vn4.reject{|x| @edges.each_key.include?(x)}.each do |x|
        @edges[x]=@edges[nxt]+val(x)
      end
      @done << nxt
    #  p @done
    end
    @edges[@bound+Point[-1,-1]]
  end

  def dump
    a = [@bound+Point[-1,-1]]
    while a.first != Point[0,0]
      a.unshift(a.first.vn4.min_by{|x| @edges[x]})
    end
    a
  end
end

pf = Pathfind.new(data)
puts pf.process
a = pf.dump
puts a.length
puts a

__END__
1163751742
1381373672
2136511328
3694931569
7463417111
1319128137
1359912421
3125421639
1293138521
2311944581

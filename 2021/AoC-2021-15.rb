#!/usr/bin/env ruby

# https://adventofcode.com/2021/day/15

require '../point'
require '../priority_queue'

PRODUCTION = true #&& false
source = PRODUCTION ? open('./input-15.txt') : DATA

data=source.readlines(chomp:true).map{|s| s.each_char.map(&:to_i)}

class Pathfind
  def initialize(mp, factor=1)
    @mp = mp
    @ib = Point[mp.first.length,mp.length]
    @factor = factor
    @bound = Point[@ib.x*@factor-1,@ib.y*@factor-1]
    Point::bound(@bound+Point[1,1])
    @cost = {Point[0,0] => 0}
    @cand = PriorityQueue.new([Point[0,0]]){|a,b| @cost[a] < @cost[b]}
  end
    
  def val(pt)
    xfac = pt.x / @ib.x
    xmod = pt.x % @ib.x
    yfac = pt.y / @ib.y
    ymod = pt.y % @ib.y
    v = @mp[ymod][xmod]
    (v-1+xfac+yfac) % 9 +1
  end

  def process
    while nxt = @cand.pop
      #puts  @done.length.to_s + " - " + nxt.to_s
      nxt.vn4.reject{|x| @cost.has_key?(x)}.each do |x|
        @cost[x]=@cost[nxt]+val(x)
        @cand << x
        return @cost[x] if (x==@bound)
      end
    end
    p @cost
  end

  def dump
    a = [@bound1]
    while a.first != Point[0,0]
      a.unshift(a.first.vn4.min_by{|x| @cost[x]})
    end
    a
  end
end

pf = Pathfind.new(data)
puts pf.process

#part 2
pf = Pathfind.new(data,5)
puts pf.process


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

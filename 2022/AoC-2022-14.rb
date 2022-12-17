#!/usr/bin/env ruby

# https://adventofcode.com/2022/day/14

PRODUCTION = true  #&& false
source = PRODUCTION ? open('AoC-2022-14.txt') : DATA
#fetch and format
data = source.readlines(chomp: true)

Coord = Struct.new(:x, :y) do
    def +(o); Coord[self.x+o.x, self.y+o.y]; end
    def -(o); Coord[self.x-o.x, self.y-o.y]; end
    def norm; Coord[self.x<=>0, self.y<=>0]; end
    DROP=[new(0,1),new(-1,1),new(1,1)]
    def drops; DROP.map{self+ _1}; end
    def inspect; "<#{self.x},#{self.y}>";end
end

class Cave
    SOURCE=Coord[500,0]
    attr_reader :ymax

    def initialize(s)
        xl,xr = *(s.flatten.map(&:x).minmax)
        @ymax = s.flatten.map(&:y).max+2
        @left = xl-1
        @widt = xr-xl+3
        size=Coord[@widt, @ymax]
        @cave=Array.new(@ymax+1){Array.new(@widt){0}}
        s.each do |r| 
            r.each_cons(2) do |(b,e)|
                d=(e-b).norm
                c=b-d
                self[c+=d]=1 until(c==e)
            end
        end
    end
    def to_s
        @cave.map{|l| l.map{['.','#','o','+'][_1]}.join('')}.join("\n")
    end
    def adj(c); c-Coord[@left,0]; end
    def [](c); @cave[adj(c).y][adj(c).x]; end
    def []=(c,v); @cave[adj(c).y][adj(c).x]=v; end
    def source; Coord[500,0]; end
end

stone=data.map do |l|
    l.split(' -> ').map{Coord[*(_1.split(',').map(&:to_i))]}
end
cave = Cave.new(stone)
#puts cave.to_s

#part 1
grains, curr = 0,cave.source
while curr.y<cave.ymax
    #p curr
    nxt = curr.drops.find{cave[_1]==0}
    if nxt
        curr=nxt
    else
        grains+=1
        cave[curr]=2
        curr=cave.source
    end
end
#puts cave.to_s
puts grains

#part 2
ym=cave.ymax
stone << [Coord[500-ym-5,ym],Coord[500+ym+5,ym]]
cave=Cave.new(stone)
grains, curr = 0,cave.source
loop do
    nxt = curr.drops.find{cave[_1]==0}
    if nxt
        curr=nxt
    else
        grains+=1
        cave[curr]=2
        break if curr.y == 0
        curr=cave.source
    end
end
#puts cave.to_s
puts grains
__END__
498,4 -> 498,6 -> 496,6
503,4 -> 502,4 -> 502,9 -> 494,9
#!/usr/bin/env ruby

# https://adventofcode.com/2022/day/15

PRODUCTION = true #&& false
source = PRODUCTION ? open('AoC-2022-15.txt') : DATA
#fetch and format
data = source.readlines(chomp: true).map do |l|
    [l.match(/or at x=(.+), y=(.+):/)[1,2].map(&:to_i),
     l.match(/is at x=(.+), y=(.+)/)[1,2].map(&:to_i)]
end
#prep

Coord = Struct.new(:x, :y) do
    def +(o); Coord[self.x+o.x, self.y+o.y]; end
    def -(o); Coord[self.x-o.x, self.y-o.y]; end
    def inspect; "<#{self.x},#{self.y}>";end
    def abs; self.x.abs+self.y.abs; end
end

data.map!{|(a,b)| c=Coord[*a];[c,(c-Coord[*b]).abs]}

#part 1
row= PRODUCTION ? 2000000 : 10
iv = data.map do |(pt, dist, *)|
    delt=dist-(row-pt.y).abs
    (pt.x-delt..pt.x+delt) if delt>0
end.select{_1}.sort_by{_1.first}
p iv.inject([iv.first]) { |a,v|
    c = a[-1]
    if c.end >= v.first
        a[-1]=(c.begin..[c.end,v.end].max)
    else
        a << v
    end
    a
}.map{_1.end-_1.begin}.sum
#part 2
diag= data.map{|(p,b)|[p.y-p.x-b,p.y-p.x+b]}.transpose
u = diag[0].product(diag[1]).
            select{|(a,b)| a-b==2}.
            map{|(a,b)| (a+b)/2}.uniq
diag= data.map{|(p,b)|[p.y+p.x-b,p.y+p.x+b]}.transpose
v = diag[0].product(diag[1]).
            select{|(a,b)| a-b==2}.
            map{|(a,b)| (a+b)/2}.uniq
xy = u.product(v).map{|(df,sm)|Coord[(sm-df)/2,(sm+df)/2]}
p xy.select {|c|data.inject(true) {|a,(p,d)|a && ((c - p).abs > d)}}.
     map{_1.x*4000000 +_1.y}.first


__END__
Sensor at x=2, y=18: closest beacon is at x=-2, y=15
Sensor at x=9, y=16: closest beacon is at x=10, y=16
Sensor at x=13, y=2: closest beacon is at x=15, y=3
Sensor at x=12, y=14: closest beacon is at x=10, y=16
Sensor at x=10, y=20: closest beacon is at x=10, y=16
Sensor at x=14, y=17: closest beacon is at x=10, y=16
Sensor at x=8, y=7: closest beacon is at x=2, y=10
Sensor at x=2, y=0: closest beacon is at x=2, y=10
Sensor at x=0, y=11: closest beacon is at x=2, y=10
Sensor at x=20, y=14: closest beacon is at x=25, y=17
Sensor at x=17, y=20: closest beacon is at x=21, y=22
Sensor at x=16, y=7: closest beacon is at x=15, y=3
Sensor at x=14, y=3: closest beacon is at x=15, y=3
Sensor at x=20, y=1: closest beacon is at x=15, y=3
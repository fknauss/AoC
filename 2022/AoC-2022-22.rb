#!/usr/bin/env ruby

# https://adventofcode.com/2022/day/22
PRODUCTION = true
source = PRODUCTION ? open('AoC-2022-22.txt') : DATA
#fetch and format
data = source.readlines(chomp: true)

#prep

Span = Struct.new(:bound, :blocks) do
    def mod(x);b = self.bound;(x-b.begin)%b.size + b.begin; end
    def hit?(x); self.blocks.include?(x); end
end

class Map
    attr_reader :rows,:cols
    def initialize(d)
        cm=0
        @rows = d.map do |r|
            f=r.index(/[\.#]/)
            b=r.rindex(/[\.#]/)
            cm = b if b>cm
            rng = (f..b)
            Span.new(rng, rng.select{r[_1]=='#'})
        end
        @cols = (0..cm).map do |c|
            f=@rows.index{_1[0].cover?(c)}
            b=@rows.rindex{_1[0].cover?(c)}
            rng = (f..b)
            Span.new(rng, rng.select{@rows[_1].blocks.include?(c)})
        end
    end
end
class Actor
    DIRS = [[:row,:col]*2,[1,1,-1,-1]].transpose
    ALT = {:row => :col, :col => :row}
    attr_reader :row, :col, :dir
    def initialize(m)
        @dir, @row, @col = 0, 0, m.rows[0].bound.begin
        @map = m
    end
    def turn(d)
        @dir = (i =[:L,:R].index(d)) ? ([-1,1][i]+@dir)%4 : @dir
        self
    end
    def inspect; "<#{col}, #{row} (#{">v<^".chars[@dir]})>"; end
    def to_s; inspect; end
    def move(n)
        st, fr = DIRS[@dir]
        st_s = (st.to_s+'s').to_sym
        ptype = ('@'+(ALT[st].to_s)).to_sym
        span = (@map.send(st_s))[send(st)]
        pos = instance_variable_get(ptype)
        run = (n+1).times.map{|i| span.mod(pos+fr*i)}
        ep = run.each_cons(2).find{span.hit?(_1[1])}&.first
        ep = run.last unless ep
        instance_variable_set(ptype, ep)
        self
    end
end

mp = Map.new(data.select{/\.+/=~_1})
me = Actor.new(mp)
mvs = data.select{/\d+/=~_1}[0].split(/([LR]*)(\d*)/).
        each_slice(3).map do |(_,t,d)|
            ts = t.to_sym unless t.empty?
            [ts, d.to_i]
        end
#part 1
mvs.each do |mv|
    me.turn(mv[0])
    me.move(mv[1])
end
p 1000*(me.row+1) + 4*(me.col+1) + me.dir

#part 2

__END__
        ...#
        .#..
        #...
        ....
...#.......#
........#...
..#....#....
..........#.
        ...#....
        .....#..
        .#......
        ......#.

10R5L5R10L4R5L5
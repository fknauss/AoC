#!/usr/bin/env ruby

# https://adventofcode.com/2022/day/12

PRODUCTION = true #&& false
source = PRODUCTION ? open('AoC-2022-12.txt') : DATA
#fetch and format
data = source.readlines(chomp: true).
              map{|x|x.chars.map{['S',*('a'..'z'), 'E'].each_with_index.to_h[_1]}}
#prep
class Map
    attr_accessor :start, :end, :h, :w
    Coord = Struct.new(:x, :y) do
        def initialize(*a); @map, self.x,self.y = *a; end
        def up;    @map.coord(self.x,self.y+1) if self.y+1<@map.h; end
        def left;  @map.coord(self.x-1,self.y) if self.x>0; end
        def right; @map.coord(self.x+1,self.y) if self.x+1<@map.w; end
        def down;  @map.coord(self.x,self.y-1) if self.y>0; end
    end

    def initialize(d)
        @data=d
        @h , @w = @data.size, @data.first.size
        sv, ev =  *@data.flatten.minmax
        y0= @data.flatten.find_index(sv)/@w
        @start=coords().find{at(_1)==sv}
        @end=coords().find{at(_1)==ev}          
    end
    
    def coord(*a); Coord.new(self,*a); end
    def coords; (0...@w).to_a.product((0...@h).to_a).map{coord(*_1)}; end
    def at (c); c && @data[c.y][c.x];end

    def neighbors(c)
        v=at(c)+1
        [c.up,c.left,c.right,c.down].select{x=at(_1);x && x<=v}
    end

    def path(from,to)
        steps=[from]
        until (steps.last.include?(to))
            steps << (steps.last.map{neighbors(_1)}.flatten.uniq-steps.flatten)
        end
        steps
    end
end
m = Map.new(data)

#part 1
p m.path([m.start],m.end).count-1
#part 2
p m.path(m.coords.select{m.at(_1)==1},m.end).count-1

__END__
Sabqponm
abcryxxl
accszExk
acctuvwj
abdefghi
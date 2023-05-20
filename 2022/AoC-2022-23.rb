#!/usr/bin/env ruby

# https://adventofcode.com/2022/day/23

PRODUCTION = true
source = PRODUCTION ? open('AoC-2022-23.txt') : DATA
#fetch and format
data = source.readlines(chomp: true)

#prep
Pos = Struct.new(:x,:y) do
    def self.[](*arg); Pos.new(*arg); end
    def +(o); Pos[self.x + o.x, self.y + o.y]; end
    def to_s; "<#{self.x}, #{self.y}>";end
    def inspect; to_s; end
end
CHECK = ([-1,0,1].product([-1,0,1])-[[0,0]]).map{Pos[*_1]}
DMASK = [[0,3,5],[2,4,7],[0,1,2],[5,6,7]]
DIRS = [[0,-1],[0,1],[-1,0],[1,0]].map{Pos[*_1]}

elves = []
data.each_with_index do |r,y|
    r.chars.each_with_index do |c,x|
        elves << Pos[x,y] if c=='#'
    end
end

def dim(e)
    b = e.map(&:to_a).transpose.map(&:minmax)
    [*b.map{|(l,h)|h-l+1}, *b.map(&:first)]
end    
def e2s(e)
    w ,h, x0,y0 = dim(e)
    m = Array.new(h){'.'*w}
    e.each{m[_1.y-y0][_1.x-x0]='E'}
    m.join("\n")
end
#puts e2s(elves)
#puts e2s(elves)

def move(elves)
    change = elves.map do |e|
        n = CHECK.map{elves.include?(_1+e)}
        next unless n.inject(&:|)
        d = 4.times.find{|d1|!DMASK[d1].map{n[_1]}.inject(&:|)}
        d && DIRS[d]
    end
    colls = elves.zip(change).map{|(a,b)| a+b if b}.
            tally.select{_1 && _2>1}.map(&:first)
    elves = elves.zip(change).map{|(a,b)| (b && !colls.include?(b+a)) ? b+a : a}
    DIRS.rotate!
    DMASK.rotate!
    elves
end

#part 1
cnt, oe = 0, []
10.times do 
    cnt += 1
    oe, elves = elves, move(elves)
end
w,h, *_ = dim(elves)
puts "",w*h-elves.size

#part 2
until elves==oe do
    cnt += 1
    oe, elves = elves, move(elves)
end
puts cnt


__END__
....#..
..###.#
#...#.#
.#...##
#.###..
##.#.##
.#..#..
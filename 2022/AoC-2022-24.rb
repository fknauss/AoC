#!/usr/bin/env ruby

# https://adventofcode.com/2022/day/24

PRODUCTION = true
source = PRODUCTION ? open('AoC-2022-24.txt') : DATA
#fetch and format
data = source.readlines(chomp: true).
              reject{/##/ =~ _1}.map{_1[1...-1]}
#prep
Pos = Struct.new(:x,:y) do
    def self.[](*arg); Pos.new(*arg); end
    def +(o); Pos[self.x + o.x, self.y + o.y]; end
    def %(o); Pos[self.x % o.x, self.y % o.y]; end
    def clamp(o); Pos[self.x.clamp(0..o.x),self.y.clamp(0..o.y)]; end
    def to_s; "<#{self.x}, #{self.y}>";end
    def inspect; to_s; end
end
BOUND = Pos[data.first.size, data.size]
FINISH = BOUND+Pos[-1,-1]
START = Pos[0,0]

DIRHASH = { ">" => Pos[1,0],
            "<" => Pos[-1,0],
            "^" => Pos[0,-1],
            "v" => Pos[0,1] }
DIRS = DIRHASH.values+[Pos[0,0]]
Storm = Struct.new(:pos, :dir) do
    def self.[](*arg); Storm.new(*arg); end
    def move; Storm[ (self.pos+self.dir)%BOUND, self.dir]; end
    def to_s; "[#{self.pos} -> #{self.dir}]"; end
    def inspect; to_s; end    
end

def make_map(d)
    m = []
    d.each_with_index do |r,y|
        r.chars.each_with_index do |c,x|
            m << Storm[Pos[x,y],DIRHASH[c]] if /[\^v<>]/ =~ c
        end
    end
    Enumerator.new() do |y|
        loop {y << m;m.map!(&:move)}
    end.lazy
end
def strmap(slist)
    tmp = Array.new(BOUND.y){"."*BOUND.x}
    slist.map(&:pos).each{|pos|tmp[pos.y][pos.x]="@"}
    tmp.join("\n")
end

storms = make_map(data)
path =[START,FINISH] 
step = 0
res =[path, path.reverse,path].map do |run|
    step += 1
    storms.drop(2).inject([]) do |starts,mp|
        step += 1
        break step unless starts
        next [] if starts.empty? && mp.include?(run[0])
        starts = [run[0]] if starts.empty?
        pots = starts.inject([]) do |a, x|
            a | DIRS.map{(_1+x).clamp(FINISH)}
        end
        pots -= mp.map(&:pos)
        #print "#{step}\r"; STDOUT.flush
        next nil if pots.include? (run[1])
        pots
    end
end
#part 1
p res[0]
#part 2
p res[2]

__END__
#.######
#>>.<^<#
#.<..<<#
#>v.><>#
#<^v^^>#
######.#
#!/usr/bin/env ruby

# https://adventofcode.com/2022/day/18

PRODUCTION = true #&& false
source = PRODUCTION ? open('AoC-2022-18.txt') : DATA
#fetch and format
data = source.readlines(chomp: true).map{eval "[#{_1}]"}

#prep
AIR = 0
ROCK = 1
H2O = 2
data.instance_eval do
    def slor1(x)
        map{|a| r = [*([0,1,2]-[x]),x].map{a[_1]}; [r,r.pop]}.
            group_by(&:first).values.map{_1.map(&:last).sort}
    end
    def slor(x)
        slor1(x).map{|a| a.slice_when{_2-_1>1}.count*2}.sum
    end
    def rng(x)
        Range.new(*slor1(x).flatten.minmax)
    end
end

#part 1
p data.slor(0)+ data.slor(1) +data.slor(2)

#part 2

rngs = (0..2).map{data.rng(_1)}
szs = rngs.map{_1.size+2}
grd = Array.new(szs[0]){Array.new(szs[1]){Array.new(szs[2],0)}}
zro = rngs.map{1-_1.min}

grd.instance_eval do
    def set(a,v)
        self[a[0]][a[1]][a[2]]=v if dig(*a)==0
    end
    DIRS=[[1,0,0],[-1,0,0],[0,1,0],[0,-1,0],[0,0,1],[0,0,-1]]
    def fill(init_p=[0]*3,v)
        q = [init_p]
        while (pos = q.shift) 
            if set(pos,v)
                q.push(*DIRS.map{|d| d.zip(pos).map(&:sum)})
            end
        end
    end
    def to_s()
        map do |i0|
            i0.map do |i2|
                i2.map{%w(. # O)[_1]}.join('')
            end.join("\n")
        end.join("\n\n")
    end
end

data.each do |x|
    xn = x.zip(zro).map(&:sum)
    grd.set(xn,ROCK)
end
grd.fill(H2O)
def slor(g)
    Enumerator.new do |y|
        g.each{|x|x.each{y << _1}}
    end
end
def faces(o)
    o.inject(0){|a,v| a+v.chunk{_1==H2O}.to_a.size-1}
end
p faces(slor(grd)) +
  faces(slor(grd.map(&:transpose))) +
  faces(slor(grd.transpose.map(&:transpose)))
#puts grd.to_s

#puts gtos(grd)
__END__
2,2,2
1,2,2
3,2,2
2,1,2
2,3,2
2,2,1
2,2,3
2,2,4
2,2,6
1,2,5
3,2,5
2,1,5
2,3,5
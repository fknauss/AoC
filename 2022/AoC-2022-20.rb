#!/usr/bin/env ruby

#   https://adventofcode.com/2022/day/20

PRODUCTION = true #&& false
source = PRODUCTION ? open('AoC-2022-20.txt') : DATA
#fetch and format
data = source.readlines(chomp: true).map(&:to_i)

#prep
SIZE = data.size
idx = (0...SIZE).to_a

#part 1
data.each_with_index do |s,i|
    pos = idx.index(i)
    idx.insert((pos+s)%(SIZE-1),idx.delete_at(pos))
end
start=idx.index(data.index(0))
p (1..3).map{data[idx[(start+_1*1000)%(SIZE)]]}.sum

#part 2
data.map!{_1*811589153}
idx = (0...SIZE).to_a
10.times do
    data.each_with_index do |s,i|
        pos = idx.index(i)
        idx.insert((pos+s)%(SIZE-1),idx.delete_at(pos))
    end
end
start=idx.index(data.index(0))
p (1..3).map{data[idx[(start+_1*1000)%(SIZE)]]}.sum

__END__
1
2
-3
3
-2
0
4
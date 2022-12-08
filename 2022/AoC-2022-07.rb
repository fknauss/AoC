#!/usr/bin/env ruby

# https://adventofcode.com/2022/day/7

PRODUCTION = true #&& false
source = PRODUCTION ? open('AoC-2022-07.txt') : DATA
#fetch and format
data = source.readlines(chomp: true)

#prep
dstack, current=[],nil
data.each do |l|
  case l
  when /\$ cd (\S+)/
    if $1=='..'
      dstack.pop
      current=dstack.last
    else
      current=Array.new
      dstack.last&.push(current)
      dstack.push(current)
    end
  when /(\d+)/
    current.push($1.to_i)
  end   
end


def trav(a)
  Enumerator.new() {|y|  a.flatten.each{y << _1}}
end

def nodes(x)
  Enumerator.new(){|y|y<<x;x.each{|a|nodes(a).each{y<<_1} if a.is_a?(Array)}}
end

sizes = nodes(dstack.first).map{trav(_1).sum}.to_a

#part 1
p sizes.select{_1<=100_000}.sum

#part 2
p sizes.select{_1>sizes.max-(70_000_000-30_000_000)}.min

__END__
$ cd /
$ ls
dir a
14848514 b.txt
8504156 c.dat
dir d
$ cd a
$ ls
dir e
29116 f
2557 g
62596 h.lst
$ cd e
$ ls
584 i
$ cd ..
$ cd ..
$ cd d
$ ls
4060174 j
8033020 d.log
5626152 d.ext
7214296 k
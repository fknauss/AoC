#!/usr/bin/env ruby

#https://adventofcode.com/2020/day/3

PRODUCTION = true #&& false
source = PRODUCTION ? open('./input-03.txt') : DATA

data = source.readlines(chomp:true).
              map {|e| e.each_char.map{|c| c=="#"}}
H = data.length
W = data.first.length

trees = ->(dy,dx)  {
  (H/dy).times.map{|i|data[i*dy][i*dx%W]}.count(true)
}

#part 1
p trees[1,3]
#part 2

counts=[[1,1],[1,3],[1,5],[1,7],[2,1]].map{|m|trees[*m]}
p counts.inject(&:*)
__END__
..##.......
#...#...#..
.#....#..#.
..#.#...#.#
.#...##..#.
..#.##.....
.#.#.#....#
.#........#
#.##...#...
#...##....#
.#..#...#.#

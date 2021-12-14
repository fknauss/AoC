#!/usr/bin/env ruby

#https://adventofcode.com/2020/day/10

PRODUCTION = true #&& false
source = PRODUCTION ? open('./input-10.txt') : DATA

data = source.readlines().map(&:to_i)

# part 1
data << 0 << (data.max+3)
diffs = data.sort.each_cons(2).map{|v| v[1]-v[0]}
p diffs.count(3)* diffs.count(1)



__END__
28
33
18
42
31
14
46
20
48
47
24
23
49
45
19
38
39
11
1
32
25
35
8
17
7
9
4
2
34
10
3

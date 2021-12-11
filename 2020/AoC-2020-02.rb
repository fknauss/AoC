#!/usr/bin/env ruby

#https://adventofcode.com/2020/day/2

PRODUCTION = true #&& false
source = PRODUCTION ? open('./2020/input-02.txt') : DATA

data = source.readlines(chomp:true).map{|l|l.scan(/(\d+)-(\d+)\s*(\w):\s*(\w+)/).first}

#part 1
df = data.filter do|param|
  lo,hi,char, pw = *param
  lo, hi = lo.to_i, hi.to_i
  (lo..hi).include?(pw.each_char.count(char))
end
p df.count

#part2
df = data.filter do|param|
  lo,hi,char, pw = *param
  lo, hi = lo.to_i, hi.to_i
  [lo,hi].count{|i| pw[i-1]==char}==1
end
p df.count


__END__
1-3 a: abcde
1-3 b: cdefg
2-9 c: ccccccccc

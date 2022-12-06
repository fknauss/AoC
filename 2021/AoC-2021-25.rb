#!/usr/bin/env ruby

# https://adventofcode.com/2021/day/25

PRODUCTION = true #&& false
source = PRODUCTION ? open('./input-25.txt') : DATA

data = source.readlines(chomp: true).
              map{|l| l.each_char.to_a}

def succ(a,b) a[(b+1)%a.length]; end
def pred(a,b) a[(b-1)%a.length]; end

def proc_row(row,char)
  row.length.times.to_a.map do |idx|
    case row[idx]
    when char
      succ(row,idx) == "." ? "." : char
    when "."
      pred(row,idx) == char ? char : "."
    else
      row[idx]
    end
  end
end

def turn(d)
  nd = d.map{|r| proc_row(r,">")}
  nd.transpose.map{|r| proc_row(r,"v")}.transpose
end

def cp(d) d.map(&:dup); end
def dump(d) d.each {|l|puts l.join};puts; end

nd = data
count = 0
begin
  count += 1
  od, nd = nd, turn(nd)
end until nd==od
puts count
__END__
v...>>.vv>
.vv>>.vv..
>>.>v>...v
>>v>>.>.v.
v>v.vv.v..
>.>>..v...
.vv..>.>v.
v.v..>>v.v
....v..v.>

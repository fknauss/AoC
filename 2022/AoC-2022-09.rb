#!/usr/bin/env ruby

# https://adventofcode.com/2022/day/9

PRODUCTION = true #&& false
source = PRODUCTION ? open('AoC-2022-09.txt') : DATA
#fetch and format
data = source.readlines(chomp: true).map{x=_1.split' ';[x[0].to_sym,x[1].to_i]}

#prep
DIR={R: '1'.to_c,L: '-1'.to_c ,U: '-i'.to_c,D: 'i'.to_c}
MOVES = data.map {|(d,c)|[d]*c}.flatten

# monkey patch <=> to work for both parts
Complex.define_method(:<=>){|z| Complex(self.real<=>z.real,self.imag<=>z.imag)}

def sim(len)
  locs, rope= [], [0.to_c]*len
  MOVES.each do |m|
    prev=rope.first+2*DIR[m] # Force move
    rope.map!{|k| k += prev<=>k if (prev-k).abs2 > 3;prev = k}
    locs<<rope.last
  end
  locs.uniq.length
end 
 
#part 1
p sim(2)

#part 2
p sim(10)

__END__
R 4
U 4
L 3
D 1
R 4
D 1
L 5
R 2
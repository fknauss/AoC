#!/usr/bin/env ruby

# https://adventofcode.com/2022/day/2

PRODUCTION = true #&& false
source = PRODUCTION ? open('./AoC-2022-02.txt') : DATA
# get rid of extraneous space in input
data = source.readlines(chomp: true).map{|s| s.sub(' ','')}

YOU=%w(A B C)     # Rock Papaer Scissors
ME=%w(X Y Z)      # part1: RPS, part2: LWD
WIN=[3,6,0]       # Draw Lose Win
PLAYS=[*0..2].product([*0..2])
def key(a,b)  YOU[a]+ME[b]; end

# part 1
SCORE1=PLAYS.to_h{[key(_1,_2),WIN[(_2-_1)%3]+_1+1]}
p data.map{SCORE1[_1]}.sum

# part 2
SCORE2=PLAYS.to_h{[key(_1,_2),WIN[(_2-1)%3]+(_1+_2-1)%3+1]}
p data.map{SCORE2[_1]}.sum

__END__
A Y
B X
C Z

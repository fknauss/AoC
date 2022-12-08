#!/usr/bin/env ruby

# https://adventofcode.com/2022/day/5

PRODUCTION = true #&& false
source = PRODUCTION ? open('AoC-2022-05.txt') : DATA
#fetch and format
data = source.readlines(chomp: true)

#prep

PART = data.find_index("")
stack=data.first(PART).map{_1.split(//)}.to_a.
    transpose.select{/\d+/ =~ _1.last }.
    map(&:reverse).map{|x| x[1..].reject{_1==" "}}
moves = data.drop(PART+1).
    map{_1.match(/(\d+).*(\d+).*(\d+)/)[1,3].map(&:to_i)}

#part 1
s = stack.map(&:dup)
moves.each do |m|
  m[0].times{s[m[2]-1].push(s[m[1]-1].pop)}
end
puts s.map(&:last).join('')
#part 2 
s=stack
moves.each do |m|
  s[m[2]-1].push(*(s[m[1]-1].pop(m[0])))
end
puts s.map(&:last).join('')

__END__
    [D]    
[N] [C]    
[Z] [M] [P]
 1   2   3 

move 1 from 2 to 1
move 3 from 1 to 3
move 2 from 2 to 1
move 1 from 1 to 2
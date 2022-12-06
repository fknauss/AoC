#!/usr/bin/env ruby

# https://adventofcode.com/2022/day/5

PRODUCTION = true #&& false
source = PRODUCTION ? open('AoC-2022-05.txt') : DATA
#fetch and format
data = source.readlines(chomp: true)

#prep

PART = data.find_index("")
rawStack=data.first(PART).map{_1.split(//)}.to_a.
    transpose.select{/\d+/ =~ _1.last }
moves = data.drop(PART+1).
    map{_1.match(/(\d+).*(\d+).*(\d+)/)[1,3].map(&:to_i)}

#part 1
stack = rawStack.map(&:reverse).map{|x| x[1..].reject{_1==" "}}
moves.each do |m|
  m[0].times{stack[m[2]-1].push(stack[m[1]-1].pop)}
end
puts stack.map(&:last).join('')
#part 2 
stack = rawStack.map(&:reverse).map{|x| x[1..].reject{_1==" "}}
moves.each do |m|
  stack[m[2]-1].push(*(stack[m[1]-1].pop(m[0])))
end
puts stack.map(&:last).join('')

__END__
    [D]    
[N] [C]    
[Z] [M] [P]
 1   2   3 

move 1 from 2 to 1
move 3 from 1 to 3
move 2 from 2 to 1
move 1 from 1 to 2
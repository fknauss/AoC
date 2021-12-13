#!/usr/bin/env ruby

#https://adventofcode.com/2020/day/7

PRODUCTION = true #&& false
source = PRODUCTION ? open('./input-07.txt') : DATA

data=source.readlines().inject({}) do |h,s|
  key = s.match(/((?:\s?\w)*)\sbags contain/)[1]
  a =  s.scan(/(\d+)\s((?:\s?\w)*) bag/).map{|c,s| [s,c.to_i]}
  h[key]=Hash[a]
  h
end

# part 1
def held_by(g,b="shiny gold")
  g.keys.filter{|k| g[k].include?(b)}
end

def chain(d,b="shiny gold")
  holder = held_by(d,b)
  return [ [b]] if holder.empty?
  holder.inject([]) do |c,v|
    c+chain(d,v).map{|l| l+[b]}
  end
end

p chain(data).length

__END__
light red bags contain 1 bright white bag, 2 muted yellow bags.
dark orange bags contain 3 bright white bags, 4 muted yellow bags.
bright white bags contain 1 shiny gold bag.
muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
dark olive bags contain 3 faded blue bags, 4 dotted black bags.
vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
faded blue bags contain no other bags.
dotted black bags contain no other bags.

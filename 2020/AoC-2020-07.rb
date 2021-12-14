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

combos = chain(data)
puts combos.flatten.uniq.count-1

# part 2
def holdn(d,bag="shiny gold")
  d[bag].each_pair.map{|k,v|holdn(d,k)*v}.sum + 1
end
p holdn(data)-1

__END__
shiny gold bags contain 2 dark red bags.
dark red bags contain 2 dark orange bags.
dark orange bags contain 2 dark yellow bags.
dark yellow bags contain 2 dark green bags.
dark green bags contain 2 dark blue bags.
dark blue bags contain 2 dark violet bags.
dark violet bags contain no other bags.
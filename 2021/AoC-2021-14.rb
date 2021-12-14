#!/usr/bin/env ruby

# https://adventofcode.com/2021/day/14


PRODUCTION = true #&& false
source = PRODUCTION ? open('./input-14.txt') : DATA

data=source.readlines(chomp:true)

template = data.first.each_char.each_cons(2).map(&:join).tally
extra = data.first[0]+data.first[-1]

ra = data.drop(2).map do |s|
  a = s.scan(/(\w*) -> (\w*)/).first
  [a[0],[a[0][0]+a[1],a[1]+a[0][1]]]
end
rules = Hash[ra]
pep = rules.keys.join.each_char.uniq
#p template,rules,pep,extra


def cycle(temp,rule)
  temp.each_key.inject(Hash.new(0)) do |c,v|
    pr = rule[v]
    c[pr[0]] += temp[v]
    c[pr[1]] += temp[v]
    c
  end
end

def proc(n,temp,rule,pep,extra)
  res = n.times.inject(temp){|c,v| cycle(c,rule)}
  res.default=0
  res[extra]+=1
  rn = pep.map do |l|
    res.each_pair.filter{|k,v| k.include?(l)}.
                 map{|k,v| k==(l+l) ? 2*v : v}.
                 sum/2
  end
end

res = proc(10,template,rules,pep,extra)
p res.max-res.min

res = proc(40,template,rules,pep,extra)
p res.max-res.min

__END__
NNCB

CH -> B
HH -> N
CB -> H
NH -> C
HB -> C
HC -> B
HN -> C
NN -> C
BH -> H
NC -> B
NB -> B
BN -> B
BB -> N
BC -> B
CC -> N
CN -> C

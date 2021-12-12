#!/usr/bin/env ruby

# https://adventofcode.com/2021/day/12

class String
  def small?
    (self =~ /^[A-Z]*$/).nil?
  end
end

PRODUCTION = true #&& false
source = PRODUCTION ? open('./input-12.txt') : DATA

data=source.readlines(chomp:true).map{|l| l.scan(/(\w+)-(\w+)/).first}

graph = data.inject(Hash.new{|h,k| h[k]=Array.new}) do |c,v|
  c[v[0]]<<v[1]
  c[v[1]]<<v[0]
  c
end

def trav(g,path=["start"],&b)
  return [path] if path.last=="end"
  g[path.last].inject([]) do |c,v|
    c += trav(g,path+[v],&b) if b[path,v]
    c
  end
end
# part 1
p trav(graph){|p,v|!(v.small? && p.include?(v))}.length

# part 2
def check(path,v)
  return false if v == "start"
  short = (path+[v]).filter(&:small?)
  short.length <= short.uniq.length+1
end

p trav(graph){|p,v|check(p,v)}.length

__END__
fs-end
he-DX
fs-he
start-DX
pj-DX
end-zg
zg-sl
zg-pj
pj-he
RW-he
fs-DX
pj-RW
zg-RW
start-pj
he-WI
zg-he
pj-fs
start-RW

#!/usr/bin/env ruby

# https://adventofcode.com/2021/day/18

require "json"

PRODUCTION = true #&& false
source = PRODUCTION ? open('./input-18.txt') : DATA
data = source.readlines(chomp: true).map{|l| JSON::parse(l)}
#data.each{|d| p d}

def is_leaf?(x) x.is_a? Numeric; end
def cp(x)
  JSON::parse(JSON::generate(x))
end

def need_x(x,p=[])
  return nil if !p.empty? && is_leaf?(x.dig(*p))
  return p if p.length == 4
  rval = need_x(x,p+[0])
  rval = need_x(x,p+[1]) if rval.nil?
  rval
end

def side_of(x,p,d) # d==0 = left, d==1 = right
  nh = p.reverse.drop_while{|i| i == d}.reverse
  return nil if nh.empty? #nothing in that direction
  nh[-1] = d
  nh << (1-d) until !nh.empty? && is_leaf?(x.dig(*nh))
  #p nh, x.dig(*nh)
  nh
end

def xplod(x,pth)
  ra = x
  #ra = cp(x)
  v = ra.dig(*pth)
  [0,1].each do |i|
    rp = side_of(ra,pth,i)
    unless rp.nil?
      idx = rp.pop
      (rp.empty? ? ra : ra.dig(*rp))[idx]+=v[i]
    end
  end
  rp = pth.dup
  idx = rp.pop
  (rp.empty? ? ra : ra.dig(*rp))[idx]=0
  ra
end

def need_s(x,p=[])
  if !p.empty?
    v = x.dig(*p)
    if is_leaf?(v)
      return (v >= 10 ? p : nil)
    end
  end
  rval = need_s(x,p+[0])
  rval = need_s(x,p+[1]) if rval.nil?
  rval
end

def split(x,pth)
  #ra = cp(x)
  ra = x
  v = ra.dig(*pth)
  v0=v/2
  v1=v-v0
  rp = pth.dup
  idx = rp.pop
  (rp.empty? ? ra : ra.dig(*rp))[idx]=[v0,v1]
  ra
end

def simplify(a)
  ra = a
  loop do
    #p ra
    if (p = need_x(ra))
      ra = xplod(ra,p)
      next
    end
    if (p = need_s(ra))
      ra = split(ra,p)
      next
    end
    return ra
  end
end

def mag(a)
  return a if is_leaf?(a)
  3*mag(a[0])+2*mag(a[1])
end

#part 1
fv = data.map{|x|cp(x)}.inject{|c,v|  simplify([c,v])}
p mag(fv)

#part 2
p data.permutation(2).map{|v|mag(simplify(cp(v)))}.max
#p simplify(data[0])
__END__
[[[0,[5,8]],[[1,7],[9,6]]],[[4,[1,2]],[[1,4],2]]]
[[[5,[2,8]],4],[5,[[9,9],0]]]
[6,[[[6,2],[5,6]],[[7,6],[4,7]]]]
[[[6,[0,7]],[0,9]],[4,[9,[9,0]]]]
[[[7,[6,4]],[3,[1,3]]],[[[5,5],1],9]]
[[6,[[7,3],[3,2]]],[[[3,8],[5,7]],4]]
[[[[5,4],[7,7]],8],[[8,3],8]]
[[9,3],[[9,9],[6,[4,9]]]]
[[2,[[7,7],7]],[[5,8],[[9,3],[0,2]]]]
[[[[5,2],5],[8,[3,7]]],[[5,[7,5]],[4,4]]]

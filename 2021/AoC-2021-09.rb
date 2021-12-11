#!/usr/bin/env ruby
  
# https://adventofcode.com/2021/day/9


data = open('./input-09.txt').readlines(chomp:true).map{|v| v.each_char.map(&:to_i).to_a}.to_a
#data = DATA.readlines(chomp:true).map{|v| v.each_char.map(&:to_i).to_a}.to_a

require "./point"

class Map2d
  def initialize(a)
    @a = a
    Point::bound(Point[@a.first.length, @a.length])
  end
  
  def val(p)
#    print p
    @a[p.y][p.x]
  end
  
end


depths = Map2d.new(data)

#part 1
  
spots = Point::all.filter{|p|
  p.vn4.inject(true){|c,v|
    c&(depths.val(p) < depths.val(v))}}

p spots.inject(0) {|c,v| c+depths.val(v)+1}

#part 2

class Map2d
  def basin(b,l=[])  
    return l if l.include?(b)
    return l if val(b)==9
    l.append(b)
    b.vn4.inject([]){|c,v| c+basin(v,l)}.uniq
  end
end

a =spots.map{|v| depths.basin(v).length}.sort.reverse
p a.take(3).inject(&:*)

#p dive(spots.first)


__END__
2199943210
3987894921
9856789892
8767896789
9899965678
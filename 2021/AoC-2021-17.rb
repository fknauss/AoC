#!/usr/bin/env ruby

# https://adventofcode.com/2021/day/17

PRODUCTION = true #&& false
source = PRODUCTION ? open('./input-17.txt') : DATA
data = source.readline(chomp: true).scan(/-?\d+/).map(&:to_i)

# part 1
x = data[2].to_i+1
p (x*x-x)/2

# part 2

class Range
  def &(othr)
    #p [self, othr]
    return nil if nil? || othr.nil?
    if self.end.nil? && othr.end.nil?
      return [self.begin,othr.begin].max..
    elsif self.end.nil?
      return nil if self.begin > othr.end
      return [self.begin,othr.begin].max..othr.end
    elsif othr.end.nil?
      return nil if othr.begin > self.end
      return [self.begin,othr.begin].max..self.end
    else
      return nil if (self.begin > othr.end)||(othr.begin > self.end)
      #b = [self.begin,othr.begin].max
      #e = [self.begin,othr.begin].max
      return [self.begin,othr.begin].max..[self.end,othr.end].min
    end
  end
end

def invtri(x)
  (Math::sqrt(1+8*x)-1)/2.0
end

def xvals(v0)
  x = 0
  (1..v0).reverse_each.map{|v| x+=v}
end

def yvals(v0)
  y = 0
  (0..).lazy.map{|v| y+=(v0-v)}.take_while{|v| yield v}.force
end

class Field
  def initialize(d)
    @xr = Range.new(*d.take(2))
    @yr = Range.new(*d.drop(2))
    @xvr = (invtri(@xr.min).ceil..@xr.max)
    @yvr = (@yr.min..-@yr.min)
    #p @xr,@yr,@xvr,@yvr
  end

  def xrange(v)
    x = xvals(v)
    idx = x.length.times.select{|i| @xr.include?(x[i]) }
    return nil if idx.min.nil?
    idx.max == x.length-1 ? (idx.min..) : (idx.min..idx.max)
  end

  def yrange(v)
    y = yvals(v){|y| y >= @yr.min}
    idx = y.length.times.select{|i| @yr.include?(y[i]) }
    return nil if idx.min.nil?
    idx.min..idx.max
  end

  def xrangelist
    xr = @xvr.zip(@xvr.map{|v| xrange(v)}).filter{|a,b| b && b.begin}
  end

  def yrangelist
    yr = @yvr.zip(@yvr.map{|v| yrange(v)}).filter{|a,b| b && b.begin}
  end
end

f = Field.new(data)

lst = f.xrangelist().product(f.yrangelist).reject do |a|
  xa, ya = *a
  i = (xa[1] & ya[1])
  #  p [a, xa[1], ya[1],i]
  i.nil?
end

#lst.sort{|a1,b1|a,b = a1.first,b1.first; a[0]==b[0] ? a[1] <=> b[1] : a[0] <=> b[0]}.each{|x| p x+[x[0][1] & x[1][1]];}

p lst.length
__END__
target area: x=20..30, y=-10..-5

#!/usr/bin/env ruby

require "./point"

b = [3,2]
Point::bound(Point[*b])

p21 = Point[2,1]
puts p21.valid?
puts p21.n8,"\n"
puts p21.vn8
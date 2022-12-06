#!/usr/bin/env ruby

var= 3.times.map{|i|"xyz".split("").rotate(i)}
pm = ["","-"].repeated_permutation(3).to_a
xform = pm.product(var).map do |s,v|
  s.zip(s.count("").even? ? v.reverse : v).map(&:join).join(", ")
end.map{|s| eval("->(x,y,z){[#{s}]}")}

p xform.map{|pr| pr.(1,2,3)}

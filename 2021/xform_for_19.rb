#!/usr/bin/env ruby

lstr = %w(xyz yzx zxy).map(&:each_char).
                       map(&:to_a).
                       product(["","-"].repeated_permutation(3).to_a).
                       map do |v,s|
  (s.count("-").even? ? v : v.reverse).zip(s).map{|(v,s)| s+v}.join(" , ")
end


xform = lstr.map{|s| eval("lambda  {|x,y,z| [#{s}]}")}
p xform.map{|pr| pr.(1,2,3)}
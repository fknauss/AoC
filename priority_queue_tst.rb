#!/usr/bin/env ruby

require "./priority_queue"

test_max = PriorityQueue.new([5,2,30,15,7])

puts "Max Heap"
while v = test_max.pop
  puts v
end

puts "Min Heap"
test_min = PriorityQueue.new([5,2,30,15,7]){|a,b|a < b}

while v = test_min.pop
  puts v
end

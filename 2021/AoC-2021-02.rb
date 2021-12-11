#!/usr/bin/env ruby

# https://adventofcode.com/2021/day/2

data = open('./2021/input-02.txt').each_line.map{|s| a=s.split; [a[0],a[1].to_i]}
data.map!{|a,b| a=='up'?['down',-b]:[a,b]}

# part 1
forward=data.filter{|a| a.first=='forward'}.map(&:last).sum
down=data.filter{|a| a.first=='down'}.map(&:last).sum

p forward*(down)

# part 2

pos = data.inject({:aim=>0,:x=>0,:y=>0}){
  |c,d| 
  
  if d[0]=='down'
    c[:aim]+=d[1] 
  else
     c[:x]+= d[1];c[:y]+=d[1]*c[:aim]
  end
  c
}

p pos[:x]*pos[:y]





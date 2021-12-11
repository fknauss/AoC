#!/usr/bin/env ruby

# https://adventofcode.com/2021/day/4

data = open('./2021/input-04.txt').each_line
numbers = data.first.split(',').map(&:to_i)
grid = data.each_slice(6).map do |l|
  l.drop(1).map{|r| r.split.map(&:to_i)}
end

# part 1

def process1(grid,num)
  num.each do |n|
    grid.each do |g|
      g.each do|r|
        r.each_index do |i|
          r[i]=0 if r[i]==n
        end
      end
      if g.map(&:sum).include?(0) || g.transpose.map(&:sum).include?(0)
        return g.map(&:sum).sum * n
      end
    end
  end
end

puts process1(grid,numbers)

#part 2

def process2(grid,num)
  num.each do |n|
    gi_list = []
    grid.each_with_index do |g,gi|
      g.each do|r|
        r.each_index do |i|
          r[i]=0 if r[i]==n
        end
      end
      if g.map(&:sum).include?(0) || g.transpose.map(&:sum).include?(0)
        return g.map(&:sum).sum*n if grid.length <= 1
        gi_list.append(gi)
      end
    end
    gi_list.reverse.each{|i|grid.delete_at i}
      
  end
end

puts process2(grid,numbers)

#!/usr/bin/env ruby

class PriorityQueue
  def initialize(l = [],&b)
    @elem = [nil]
    @comp = block_given? ? b : proc{|a,b| a > b}
    l.each{|i| self << i}
  end
  
  def <<(l)
    @elem << l
    bubbleup(@elem.length-1)
    #p @elem
  end
  
  def pop
    return nil if @elem.length == 1
    swap(1,@elem.length-1)
    max = @elem.pop
    bubbledown(1)
    max
  end
  
  def bubbledown(idx)
    ni = idx*2
    return if (ni > (@elem.length - 1))        #past bottom
    ni += 1 if ((ni+1 <= @elem.length-1) && @comp[@elem[ni+1], @elem[ni]])
    return if @comp[@elem[idx], @elem[ni]]
    swap(idx, ni)
    bubbledown(ni)
  end
  
  def bubbleup(idx)
    return if idx <= 1
    par = idx/2
    return if @comp[@elem[par], @elem[idx]]
    swap(par,idx)
    bubbleup(par)
  end

  def swap(a,b)
    @elem[a],@elem[b] = @elem[b],@elem[a]
  end
  
end
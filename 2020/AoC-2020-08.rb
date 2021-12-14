#!/usr/bin/env ruby

#https://adventofcode.com/2020/day/8

PRODUCTION = true #&& false
source = PRODUCTION ? open('./input-08.txt') : DATA

Op = Struct.new(:inst, :val)
data = source.readlines().map do |i|
  ia = i.split(' ')
  Op[ia[0].to_sym, ia[1].to_i]
end

class Machine
  attr_accessor :acc, :ptr, :complete
  def initialize(is,swap=-1)
    @acc = 0
    @ptr = 0
    @complete = false
    @swap = swap
    @inst = is
    @hist = []
  end
  
  def step
    swap = {:nop => :jmp, :jmp=> :nop, :acc=>:acc}
    return false if @hist.include?(@ptr)
    if (@ptr == @inst.length)
      @complete=true
      return false
    end
    @hist << @ptr
    
    inst = @inst[@ptr].inst 
    inst = swap[inst] if @ptr == @swap
    case(inst)
    when :acc
      @acc += @inst[@ptr].val
      @ptr += 1
    when :jmp
      @ptr += @inst[@ptr].val
    when :nop
      @ptr += 1      
    end
    true
  end
end

# part 1
m =Machine.new(data)
while m.step; end
puts m.acc

# part 2
data.length.times do|idx|
  m = Machine.new(data, idx)
  while m.step; end
  puts m.acc if m.complete
end


__END__
nop +0
acc +1
jmp +4
acc +3
jmp -3
acc -99
acc +1
jmp -4
acc +6
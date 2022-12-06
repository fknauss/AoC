#!/usr/bin/env ruby

# https://adventofcode.com/2021/day/24

PRODUCTION = true && false
source = PRODUCTION ? open('./input-24.txt') : DATA

data = source.readlines(chomp: true).map{|s| s.split.take(3)}
#p data

class ALU
  attr :fault, :reg
  def initialize(inst)
    reset
    @code = inst
    @inp_len = @code.count{|op|op.first == "inp"}
  end

  def reset
    @reg = Hash["wxyz".split("").zip([0]*4)]
    @fault = false
  end

  def rv(v)
    @reg.keys.include?(v) ? @reg[v] : v.to_i
  end

  def add(r,v)
    reg[r] += rv(v)
  end
  def mul(r,v)
    reg[r] *= rv(v)
  end
  def div(r,v)
    vt = rv(v)
    return @fault = true if vt ==0
    sgn = (!(@reg[r]<0) != !(vt<0)) ? -1 : 1
    @reg[r] = (@reg[r].abs / vt.abs)*sgn
  end
  def mod(r,v)
    vt = rv(v)
    return @fault = true if vt <=0
    reg[r] %= rv(v)
  end
  def eql(r,v)
    reg[r] = reg[r] == rv(v) ? 1 : 0
  end
  def inp(r)
    reg[r] = @inp_q.shift
  end

  def run(inp)
    @inp_q = inp.split("").map(&:to_i)
    return nil if @inp_q.length != @inp_len
    reset
    @code.each do |(op,*r)|
      #p [op, r, @reg]
      return nil if @fault
      case op
      when "inp"
        inp(r.first)
      when "add"
        add(*r);
      when "mul"
        mul(*r);
      when "div"
        div(*r);
      when "mod"
        mod(*r);
      when "eql"
        eql(*r);
      end
    end
  end
end


class ALU_Hand
  Ops = Struct.new(:cmp, :add, :pop)
  def  initialize
    reset
    @ops = [
      [13, 3, false],
      [11, 12, false],
      [15, 9, false],
      [-6, 12, true],
      [15, 2, false],
      [-8, 1, true],
      [-4, 1, true],
      [15, 13, false],
      [10, 1, false],
      [11, 6, false],
      [-11, 2, true],
      [0, 11, true],
      [-8, 10, true],
      [-7, 3, true]
    ].map{|s| Ops.new(*s)}
  end

  def reset
    @stack = [0]
  end

  def run(inp)
    inp_q = inp.split("").map(&:to_i)
    reset
    @ops.each do |op|
      w = inp_q.shift
      s = op.pop ? @stack.pop : @stack.last
      @stack.push(w + op.add) unless w == (s + op.cmp)
      p [op,@stack]
    end
    @stack#.inject{|c,v|c*26+v}
  end

  def reverse
    reset
    opts = {}
    @ops.each_with_index.reverse_each do |op, i|
      if op.pop
        @stack << [op.cmp,i]
      else
        e = @stack.pop
        v = op.add+e[0]
        opts[i] = -v
        opts[e[1]] = v
      end
    end
    opts.length.times.map do |i|
      v = opts[i]
      v > 0 ? (v+1..9) : (1.. 9+v)
    end
  end
end

#alu = ALU.new(data)
#i = 43579246899399
#inp = i.to_s

alu2 = ALU_Hand.new()
#p alu2.run(inp)
rev = alu2.reverse

puts rev.map{|r| r.last.to_s}.join
puts rev.map{|r| r.first.to_s}.join

__END__
inp w _         #1
mul x 0         clear x
add x z         move z to x
mod x 26        get low 25
div z 1         leave z alone (peek at z without pop)
add x 13        add 13
eql x w         check if equal
eql x 0         NOT equal (flag)
mul y 0         clear y
add y 25        set y to 25
mul y x         make 0 if was not equal
add y 1         make either 1 or 26
mul z y         slide z over if w was not equal to peek(z)+13
mul y 0
add y w
add y 3         add 3 to w
mul y x         FLAG
add z y         add to z
inp w _         #2
mul x 0
add x z
mod x 26
div z 1         peek
add x 11        add 11 for compare
eql x w
eql x 0         compare - 1 if not equal
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 12        add 12 before push
mul y x
add z y
inp w _         #3
mul x 0
add x z
mod x 26
div z 1
add x 15        add 15 before compare
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 9         add 9 before push
mul y x
add z y
inp w _         #4
mul x 0
add x z
mod x 26
div z 26        pop, not peek!
add x -6        -6 before compare!
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 12        +12 before push
mul y x
add z y
inp w _         #5
mul x 0
add x z
mod x 26
div z 1         peek
add x 15        + 15 compare
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 2         add 2 before push
mul y x
add z y
inp w _         # 6
mul x 0
add x z
mod x 26
div z 26        pop
add x -8        cmp -8
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 1         add 1 before push
mul y x
add z y
inp w _         #7
mul x 0
add x z
mod x 26
div z 26
add x -4
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 1
mul y x
add z y
inp w _       # 8
mul x 0
add x z
mod x 26
div z 1
add x 15
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 13
mul y x
add z y
inp w _       # 9
mul x 0
add x z
mod x 26
div z 1
add x 10
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 1
mul y x
add z y
inp w _     #10
mul x 0
add x z
mod x 26
div z 1
add x 11
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 6
mul y x
add z y
inp w _        #11
mul x 0
add x z
mod x 26
div z 26
add x -11
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 2
mul y x
add z y
inp w _     #12
mul x 0
add x z
mod x 26
div z 26
add x 0
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 11
mul y x
add z y
inp w _       #13
mul x 0
add x z
mod x 26
div z 26
add x -8
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 10
mul y x
add z y
inp w _     #14
mul x 0
add x z
mod x 26
div z 26
add x -7
eql x w
eql x 0
mul y 0
add y 25
mul y x
add y 1
mul z y
mul y 0
add y w
add y 3
mul y x
add z y

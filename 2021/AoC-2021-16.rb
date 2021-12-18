#!/usr/bin/env ruby

# https://adventofcode.com/2021/day/16

PRODUCTION = true #&& false
source = PRODUCTION ? open('./input-16.txt') : DATA

Info = Struct.new(:version, :type, :data)
class String
  def grab!(n)
    self.slice!(0...n).to_i(2)
  end
end

data=source.readlines(chomp:true).map{|s| s.each_char.map{|c| c.to_i(16)}}
#p data
data = data.map{|l| l.map{|i| "%04b" % i}.join}
#p data

 
def decode(s)
  version = s.grab!(3)
  type = s.grab!(3)
  val = []
  if type == 4
    val = 0
    loop do 
      tmp = s.grab!(5)
      val =val*16 + tmp%16
      break if tmp < 16
    end
  else
    ltype = s.grab!(1)
    if ltype == 0 #15 bits of bit count
      bitcount = s.grab!(15)
      substr = s.slice!(0...bitcount)
      while substr.length>0
        val << decode(substr)
      end
    else            # 11 bits of packet count
      packetcount = s.grab!(11)
      packetcount.times {val << decode(s)}
    end
  end
  return Info[version, type, val]    
  
end

data.map!{|s| decode(s)}

# part 1

def version_sum(x)
  rval = x.version
  if x.data.is_a? Array
    rval += x.data.map{|d| version_sum(d)}.sum
  end
  rval
end

data.each do |x|
  p version_sum(x)
end

# part 2

def eval(x)
  rval = 0
  case x.type
  when 0
    rval = x.data.map{|v| eval(v)}.sum
  when 1
    rval = x.data.inject(1){|c,v| c* eval(v)}
  when 2
    rval = x.data.map{|v| eval(v)}.min
  when 3
    rval = x.data.map{|v| eval(v)}.max
  when 4
    rval = x.data
  when 5
    rval = eval(x.data[0]) > eval(x.data[1]) ? 1 : 0 
  when 6
    rval = eval(x.data[0]) < eval(x.data[1]) ? 1 : 0 
  when 7
    rval = eval(x.data[0]) == eval(x.data[1]) ? 1 : 0 
  else
    puts "ALERT!"
  end
  # x.type, rval
  rval
end

data.each {|x| puts eval(x)}

__END__
D2FE28
38006F45291200
EE00D40C823060
8A004A801A8002F478
620080001611562C8802118E34
C0015000016115A2E0802F182340
A0016C880162017C3686B18A3D4780

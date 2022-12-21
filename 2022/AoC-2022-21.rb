#!/usr/bin/env ruby

# https://adventofcode.com/2022/day/21

PRODUCTION = true #&& false
source = PRODUCTION ? open('AoC-2022-21.txt') : DATA
#fetch and format
data = source.readlines(chomp: true)

#prep

Yell = Struct.new(:op, :a, :b)
yells = Hash.new

data.each do |l|
    case l
    when /(\w*): (\w*) (\W) (\w*)/
        yells[$1.to_sym]=Yell[*[$3,$2,$4].map(&:to_sym)]
    when /(\w*): (\d*)/
        yells[$1.to_sym]=Yell[nil, $2.to_i,nil]
    end
end
 
# n = x + b => x = n-b
# n = a + x => x = n-a
# n = a - x => x = a-n
yells.instance_eval do
    def human=(x) @hm=x; end
    def initialize; @hm = false; end
    def hear(k = :root)
        inv = {:+ => :-, :- => :+, :* => :/, :/ => :*}
        return ->(x){x} if @hm && k==:humn  # start inversion chain
        c = self[k]
        return c.a unless c.op
        a = self.hear(c.a)
        b = self.hear(c.b)
        if @hm && Proc === a            # inverse right side
            return a.(b) if k == :root  # process chain
            ->(x){a.(x.send(inv[c.op], b))} 
        elsif @hm && Proc === b         # inverse left side
            return b.(a) if k ==:root   # process chain
            if [:+,:*].include? c.op    # commutes
                ->(x){b.(x.send(inv[c.op], a))}
            else                        # swaps w/o inversion
                ->(x){b.(a.send(c.op, x))}
            end
        else                            # no inversion
            a.send(c.op, b)
        end
    end
end

#part 1
p yells.hear()

#part 2
yells.human=true
p yells.hear()

__END__
root: pppw + sjmn
dbpl: 5
cczh: sllz + lgvd
zczc: 2
ptdq: humn - dvpt
dvpt: 3
lfqf: 4
humn: 5
ljgn: 2
sjmn: drzm * dbpl
sllz: 4
pppw: cczh / lfqf
lgvd: ljgn * ptdq
drzm: hmdt - zczc
hmdt: 32
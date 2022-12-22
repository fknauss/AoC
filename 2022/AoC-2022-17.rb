#!/usr/bin/env ruby

# 

PRODUCTION = true #&& false
source = PRODUCTION ? open('AoC-2022-17.txt') : DATA
#fetch and format
data = *source.readline(chomp: true).chars.map(&:to_sym)

class Block
    attr_reader(:p, :y, :type)
    def self.[] (*x) Block.new(*x); end
    B =[
        ["1111"],
        ["010","111","010"],
        ["111","001","001"],
        ["1","1","1","1"],
        ["11","11"]
    ].map{|x| x.map{_1.to_i(2)}}
    P =[
        [0,0,0,0],
        [1,2,1],
        [0,0,2],
        [3],
        [1,1]
    ]
    def initialize(type, y=0, p = nil)
        @type, @y= type, y 
        @p = p || 5-w
    end
    def clone; Block.new(@type, @y, @p); end
    def h; B[@type].length; end
    def w; B[@type].map{ Math::log2(_1<<1).floor}.max; end
    def b; B[@type].map{_1<<@p};end
    def top; @y+h; end
    def to_s; b.reverse.map{("%07b"%_1).tr("01",".#")}.join("\n");end
    def inspect; to_s(); end
    def col(o)
        dy = o.y - @y
        return o.col(self) if dy < 0
        b.zip([0]*dy+o.b).map{|(a,b)| b && (a & b) != 0}.inject(&:|)
    end
    def left ; clone.left!; end
    def left!; @p += (@p+w < 7 ? 1 : 0); self;end
    def rite ; clone.rite!; end
    def rite!; @p -= (@p > 0   ? 1 : 0); self; end
    def down ; clone.down!; end
    def down!; @y -= 1; self; end
    def coord; [@y,@p];end
    def profile(prf)
        c= [nil]*(7-@p-w)+P[@type].map{_1+@y}
        prf.zip(c).map{_1[1]? _1.max : _1[0]}
    end
end

class Stack
    attr_accessor(:stk, :wc, :profile)
    TOP=30
    SAMPLE = 3000
    def initialize(w)
        @stk = []
        @bt = (0...5).cycle
        @w = w.cycle
        @profile = [-1]*7
    end

    def top; @stk.last(TOP).map(&:top).max||0; end
    def laps(y); @stk.last(TOP).select{_1.top >= y}; end
    def col(b); laps(b.y).inject(false){|a,v| a || b.col(v)}; end

    def drop
        @stk =[]
        Enumerator.new do |y|
            loop do
                b = Block[@bt.next, top+3]
                loop do
                    b = horiz(b)
                    break unless nb = vert(b)
                    b = nb
                end
                @stk << b
                y << b
            end
        end
    end

    def horiz(b)
        nb = (@w.next == :< )? b.left : b.rite
        col(nb) ? b : nb
    end
    
    def vert(b)
        nb = b.down
        nb.y >= 0 && !col(nb) && nb
    end

    def go(n, force=false)
        return (drop.take(n); top) if  n<SAMPLE && !force
        bi,bh, dh = pattern
        div,mod = (n-bi).divmod(dh.size)
        bh +div*dh.sum + dh.take(mod).sum
    end

    def pattern(db=false)
        drp = drop
        dstack, ys, cp = [], [], [-1]*7

        SAMPLE.times do |k|
            b = drp.next
            ys << top
            cp = b.profile(cp)
            dstack<< [cp.map{_1-cp.min}, b.type, b.p]
        end
 
        period = (dstack.size - 1- dstack[0...-1].rindex(dstack.last))
        beginning = (SAMPLE-1).downto(period).find{|i| dstack[i] != dstack[i-period]}-period+1
        beg_h = ys[beginning]
        dlt_h = ys[beginning..beginning+period].each_cons(2).map{|(a,b)| b-a}
        p ys.take(beginning+period).to_a if db
        p beginning, beg_h, dlt_h if db
        [beginning+1, beg_h, dlt_h]
    end
end
#prep
#p Stack.new(data).go(2022).top
#part 1
p Stack.new(data).go(2022)
#part2
p Stack.new(data).go(1000000000000)

__END__
>>><<><>><<<>><>>><<<>>><<<><<<>><>><<>>
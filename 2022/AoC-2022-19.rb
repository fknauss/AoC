#!/usr/bin/env ruby

# https://adventofcode.com/2022/day/19

PRODUCTION = true && false
source = PRODUCTION ? open('AoC-2022-19.txt') : DATA
#fetch and format
data = source.readlines(chomp: true)

#prep
Blueprint = Struct.new(:id, :cost) do
    def initialize(l)
        self.cost = []
        /print (?<p1>\d+)/ =~ l
        self.id = p1.to_i
        /ore robot costs (?<p1>\d+)/ =~ l
        self.cost[0]=[p1.to_i,0,0]
        /clay robot costs (?<p1>\d+)/ =~ l
        self.cost[1]=[p1.to_i,0,0]
        /dian robot costs (?<p1>\d+) ore and (?<p2>\d+)/ =~ l
        self.cost[2]=[p1.to_i, p2.to_i,0] 
        /ode robot costs (?<p1>\d+) ore and (?<p2>\d+)/ =~ l
        self.cost[3]=[p1.to_i,0, p2.to_i] 
    end    
    def max_cost
        [*self.cost.transpose.map(&:sum),0]
    end
end

Factory = Struct.new(:res, :prod, :t, :bp, :tmax, :mc) do
    def initialize(bp,tmax)
        self.bp, self.tmax = bp, tmax
        self.t, self.res, self.prod = 0,[0,0,0,0],[1,0,0,0]
        self.mc = bp.max_cost
    end
    def clone; Marshal.load(Marshal.dump(self)); end
    def time_to(type)
        want = self.bp.cost[type]
        want.zip(self.res, self.prod).map do |(w,r,m)|
            if m==0
                w == 0 ? 0 : 1000
            else
                ((w-r)/m.to_f).ceil
            end
        end.max
    end
    def wait(t)
        t = [t,self.tmax-self.t].min
        self.t += t
        self.res = self.res.zip(self.prod).map do |r,m|
            r+m*t
        end
        self
    end
    def done
        #p [self.prod,self.res] if self.t == self.tmax
        self.res[3] if self.t == self.tmax
    end
    def build(type)
        return unless self.res.zip(self.bp.cost[type]).
                           map{_1>=(_2||0)}.inject(&:&)
        self.res = self.res.zip(self.bp.cost[type]).map{_1-(_2||0)}
        wait(1)
        self.prod[type]+=1
        self
    end
    def wb(type)
        return if (t=time_to(type)) > (self.tmax-self.t)
        wait(t)
        self if build(type)
    end
end

$trim=[0,0,0,0]
def best(f,msf=0)
    return unless f
    etime = [15,7,3,0]
    mfac = [5,7,9,200]
    tleft = f.tmax-f.t
    3.downto(0).map do |type|
        $trim[0]+=1; next 0 if (f.prod[type] > mfac[type])
        #$trim[1]+=1; next 0 if tleft < etime[type]
        $trim[2]+=1; next 0 if f.res[3] + tleft*(tleft+2*f.prod[3])/2 < msf
        $trim[3]+=1; next 0 if f.res[type] > (2*f.mc[type])
        nf = f.clone.wb(type)
        rval=nf&.done
        msf = [msf,rval].max if rval
        rval || best(nf) || 0
    end.max
end

bp = data.map{Blueprint.new(_1)}
#part 1
qr = bp.map do |b|
    f = Factory.new(b,24)
    best(f)*(b.id)
end
p qr.sum
p $trim
#part 2

__END__
Blueprint 1: Each ore robot costs 4 ore. Each clay robot costs 2 ore. Each obsidian robot costs 3 ore and 14 clay. Each geode robot costs 2 ore and 7 obsidian.
Blueprint 2: Each ore robot costs 2 ore. Each clay robot costs 3 ore. Each obsidian robot costs 3 ore and 8 clay. Each geode robot costs 3 ore and 12 obsidian.
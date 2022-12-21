#!/usr/bin/env ruby

# https://adventofcode.com/2022/day/16

PRODUCTION = true && false
source = PRODUCTION ? open('AoC-2022-16.txt') : DATA
#fetch and format
data = source.readlines(chomp: true)
#prep

rgraph = Hash.new
rrates = Hash.new
data.each do |l|
    k = l.match(/Valve (\w+)/)[1]
    r = l.match(/rate=(\d+)/)[1].to_i
    rgraph[k] = l.match(/valves? (.*)/)[1].split(", ")
    rrates[k]=r if r>0
end
idx = rrates.keys.each_with_index.to_h
rates = rrates.values

dist = Array.new
[*idx.keys,"AA"].map do |start|
    steps, nxt =[], [start]
    until nxt.empty?
        steps << nxt
        nxt = nxt.map{rgraph[_1]}.flatten
        nxt -= steps.flatten;
    end
    dist[idx[start]||idx.size] = (idx.keys).map{|k| 1+steps.index{_1.include?(k)}}
end
p rates, dist

def routes(dst,vstd,clock)
    curt = dst[vstd.first]
    choice = curt.size.times.select{curt[_1]<clock}
    return [[vstd.first]] if choice.empty?
    nr = [[]] + choice.map{routes(dst,[_1,*vstd],clock-curt[_1])}.inject(&:+)
    nr.map{[vstd.first, *_1]} if nr
end

def flow(dst,rts, pth, clock)
    p pth
    pth.each_cons(2).map {|(s,e)|(clock -= dst[s][e])*rts[e]}.sum
end

#part 1
r = routes(dist, [rates.size], 30)
p
#r.map{flow(dist, rates, _1, 30)}.max

#part 2
#r = routes(dist, ["AA"], 26)
#p r.size
#p r.combination(2).select{|(a,b)| (a&b)==["AA"]}.size


__END__
Valve AA has flow rate=0; tunnels lead to valves DD, II, BB
Valve BB has flow rate=13; tunnels lead to valves CC, AA
Valve CC has flow rate=2; tunnels lead to valves DD, BB
Valve DD has flow rate=20; tunnels lead to valves CC, AA, EE
Valve EE has flow rate=3; tunnels lead to valves FF, DD
Valve FF has flow rate=0; tunnels lead to valves EE, GG
Valve GG has flow rate=0; tunnels lead to valves FF, HH
Valve HH has flow rate=22; tunnel leads to valve GG
Valve II has flow rate=0; tunnels lead to valves AA, JJ
Valve JJ has flow rate=21; tunnel leads to valve II
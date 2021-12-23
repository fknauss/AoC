#!/usr/bin/env ruby

# https://adventofcode.com/2021/day/21

PRODUCTION = true #&& false
source = PRODUCTION ? open('./input-21.txt') : DATA
data = source.readlines(chomp: true)
data.map!{|s| /\d+$/.match(s)[0].to_i}
#p data

def mod1(a,b) (a-1)%b +1 ; end

die1 = Enumerator.new() do |y|
  v = 0
  loop do
    y << 3+v%100+(v+1)%100+(v+2)%100
    v+=3
  end
end

def play(pos,die)
  score = [0,0]
  a = (0..).each do |turns|
    player = turns%2
    pos[player] = mod1(pos[player]+die.next,10)
    score[player] += pos[player]
    #p [player,score[player]]
    break [turns,player] if score[player]>=1000
  end
  score[1-a[1]]*3*(a[0]+1)
end

p play(data.dup,die1)

def to21(pos, score=0)
  # p pos,score
  rc = [1,3,6,7,6,3,1]
  np = (3..9).map{|d| mod1(d+pos,10)}
  ns = np.map{|v|v+score}
  rv = Hash.new(0)
  rv[0] = ns.zip(rc).inject(0){|c,v| v[0]<21 ? c : c+v[1]}
  np.zip(ns,rc).each do |pos,score,mult|
    next unless score < 21
    tmp = to21(pos,score)
    tmp.each_key{|k| rv[k+1]+= mult * tmp[k]}
  end
  rv
end

res = data.map do |p|
  h = to21(p)
  a = h.each_key.sort.map{|k|h[k]}
end

wpt = res[0].zip(res[1]).flatten
player = 0
wins = [0,0]
uv = [1,1]
wpt.each do |w|
  wins[player]+= uv[1-player]*w
  uv[player] = uv[player]*27-w
  #p [player,wins,uv]
  player = 1-player
end

p wins.max

__END__
Player 1 starting position: 4
Player 2 starting position: 8

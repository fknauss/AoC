#!/usr/bin/env ruby

# https://adventofcode.com/2021/day/2p


PRODUCTION = true# && false
source = PRODUCTION ? open('./input-20.txt') : DATA
data = source.readlines(chomp: true)

filter = data[0].each_char.map{|c| c == "#" ? 1 : 0}

img = data[2..].map{|l| l.each_char.map{|c| c == "#" ? 1 : 0}}

def nabor(x)
  [-1,0,1].map{|o| x[1]+o}.product([-1,0,1].map{|o| x[0]+o}).map(&:reverse)
end
#p nabor([3,7])

PADSIZE = 52
ITER = 2

img.map!{|l| [0]*PADSIZE + l + [0]*PADSIZE}

img = [[0]*img[0].length]*PADSIZE + img + [[0]*img[0].length]*PADSIZE

def disp(m)
  m.each{|l| puts l.map{|v| %w(. #)[v]}.join}
end

do_filt = -> i {
  hit = i.length
  wid = i[0].length
  ri = (1...hit-1).map do |y|
    (1...wid-1).map do |x|
      idx = nabor([x,y]).inject(0){|c,v| c*2 + i[v[1]][v[0]]}
      filter[idx]
    end
  end
  ri.map!{|l| [l[0]] + l + [l[-1]]}
  [ri[0]]+ ri + [ri[-1]]
}

# part 1
r = img
2.times{r = do_filt.call(r)}
p r.map(&:sum).sum

# part 2
48.times{r = do_filt.call(r)}
p r.map(&:sum).sum

#xxx

#xxx
__END__
..#.#..#####.#.#.#.###.##.....###.##.#..###.####..#####..#....#..#..##..###..######.###...####..#..#####..##..#.#####...##.#.#..#.##..#.#......#.###.######.###.####...#.##.##..#..#..#####.....#.#....###..#.##......#.....#..#..#..##..#...##.######.####.####.#.#...#.......#..#.#.#...####.##.#......#..#...##.#.##..#...##.#.##..###.#......#.#.......#.#.#.####.###.##...#.....####.#..#..#.##.#....##..#.####....##...##..#...#......#.#.......#.......##..####..#...#.#.#...##..#.#..###..#####........#..####......#..#

#..#.
#....
##..#
..#..
..###

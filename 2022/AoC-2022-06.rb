#!/usr/bin/env ruby

# AoC-2022-06.rb 

PRODUCTION = true #&& false
source = PRODUCTION ? open('AoC-2022-06.txt') : DATA
#fetch and format
data = source.readline(chomp: true).chars

#prep
def data.ucl(n)
  self.each_cons(n).with_index.find{|(a,_)|a.uniq.size == n}[1]+n
end

#part 1
p data.ucl(4)

#part 2
p data.ucl(14)

__END__
mjqjpqmgbljsphdztnvjfqwrcgsmlb
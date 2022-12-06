#!/usr/bin/env ruby

# AoC-2022-06.rb 

PRODUCTION = true #&& false
source = PRODUCTION ? open('AoC-2022-06.txt') : DATA
#fetch and format
data = source.readlines(chomp: true)[0].chars

#prep
def fp(data,l)
  data.each_cons(l).with_index.find{|(a,b)|a.uniq.size == l}[1]+l
end

#part 1
p fp(data,4)

#part 2
p fp(data,14)

__END__
mjqjpqmgbljsphdztnvjfqwrcgsmlb
#!/usr/bin/env ruby

# https://adventofcode.com/2022/day/25

PRODUCTION = true
source = PRODUCTION ? open('AoC-2022-25.txt') : DATA
#fetch and format
data = source.readlines(chomp: true)

#prep
String.class_eval do
    def to_elf
        self.tr("=\\-012",'01234').
             chars.map{_1.to_i-2}.
             inject{|m,v|m*5+v}
    end
end

Integer.class_eval do
    def to_elf
        tmp, sa = self, []
        while tmp>0
            d = tmp%5
            sa.prepend("012=-".chars[d])
            d -= 5 if d >2
            tmp = (tmp - d)/5
        end
        sa.join('')
    end
end

#part 1
puts data.map(&:to_elf).sum.to_elf
#part 2

__END__
1=-0-2
12111
2=0=
21
2=01
111
20012
112
1=-1=
1-12
12
1=
122
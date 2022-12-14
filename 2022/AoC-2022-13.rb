#!/usr/bin/env ruby

# https://adventofcode.com/2022/day/13

PRODUCTION = true #&& false
source = PRODUCTION ? open('AoC-2022-13.txt') : DATA
#fetch and format
data = source.readlines(chomp: true).map{eval _1}.find_all{_1}

#prep
def comp(a,b)
    def ins_a(a) (Array === a) ? a : [a]; end
    return 1 if b.nil?
    return (a<=>b) if (Numeric === a) && (Numeric === b)
    if (Array === a) && (Array === b)
        a.zip(b).each{x=comp(*_1); return x if x!=0}
        return comp(a.length,b.length)
    end
    comp(ins_a(a),ins_a(b))
end

#part 1
p data.each_slice(2).with_index.select{comp(*(_1[0]))<0}.map{_1[1]+1}.sum

#part 2
post = [*(M1, M2=[[2]],[[6]]),*data].sort{comp(_1,_2)}
p (post.find_index(M1)+1)*(post.find_index(M2)+1)

__END__
[1,1,3,1,1]
[1,1,5,1,1]

[[1],[2,3,4]]
[[1],4]

[9]
[[8,7,6]]

[[4,4],4,4]
[[4,4],4,4,4]

[7,7,7,7]
[7,7,7]

[]
[3]

[[[]]]
[[]]

[1,[2,[3,[4,[5,6,7]]]],8,9]
[1,[2,[3,[4,[5,6,0]]]],8,9]
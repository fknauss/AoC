#!/usr/bin/env ruby

# https://adventofcode.com/2021/day/10

PRODUCTION = true # && false
source = PRODUCTION ? open('./2021/input-10.txt') : DATA

CLOSE = {'<' => '>', '(' => ')', '[' =>']', '{' =>'}' }

def is_open?(c)
  CLOSE.keys.include?(c)
end

# horrible hack - return character on error or array for stack if incomplete
def process(s)
  s.each_char.inject([]) do |stack, c|
    if is_open?(c)
      stack.push CLOSE[c]
    else
      return c if c != stack.pop
    end
    stack
  end
end

data=source.readlines(chomp:true).map{|x| process(x)}

# part 1
VALUE1 = {')'=> 3, ']' => 57, '}' => 1197, '>' => 25137 }

p data.reject{|x|x.is_a?(Array)}.map{|c| VALUE1[c]}.sum

# part 2
VALUE2 = {')'=> 1, ']' => 2, '}' => 3, '>' => 4 }

scores = data.filter{|x|x.is_a?(Array)}.map{|x| x.reverse.inject(0){|c,v| c*5+VALUE2[v]}}.sort
p scores[(scores.length-1)/2]

__END__
[({(<(())[]>[[{[]{<()<>>
[(()[<>])]({[<{<<[]>>(
{([(<{}[<>[]}>{[]{[(<()>
(((({<>}<{<{<>}{[]{[]{}
[[<[([]))<([[{}[[()]]]
[{[{({}]{}}([{[{{{}}([]
{<[[]]>}<{[{[{[]{()[[[]
[<(<(<(<{}))><([]([]()
<{([([[(<>()){}]>(<<{{
<{([{{}}[<[[[<>{}]]]>[]]
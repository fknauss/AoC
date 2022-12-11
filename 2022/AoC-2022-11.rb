#!/usr/bin/env ruby

# https://adventofcode.com/2022/day/11

PRODUCTION = true #&& false
source = PRODUCTION ? open('AoC-2022-11.txt') : DATA
#fetch and format
data = source.readlines(chomp: true).slice_after("").map{_1.join("\n")}

#prep
class Barrel
    attr_accessor :div, :mod
    def initialize; @monkeys = [];@div = 0;@mod = 1;end
    def reset(d);   @div = d;@monkeys.each(&:reset);self;end
    def round(n);   n.times{@monkeys.each(&:turn)};@monkeys;end
    def [](i);      @monkeys[i];end
    def add_monkey(p); @monkeys << Monkey.new(p, self);end

    class Monkey
        def initialize (p, b)
            @orig, @op, @tst, @p, @f = *p
            @barrel = b
            b.mod *=@tst
        end
        def turn
            @i.each do |i|
                @count += 1
                n = (@op.call(i)/@barrel.div) % @barrel.mod
                @barrel[n % @tst==0 ? @p : @f].give(n)
            end
            @i = Array.new
            self
        end
        def give(i) @i << i; self; end
        def reset; @count=0; @i = @orig.dup; end
        def count; @count; end
    end
end

b = Barrel.new
data.each do |ch|
    inp=[
        ch.match(/items: (.*)\n/)[1].split(',').map(&:to_i),
        ->(old) {eval ch.match(/new = (.*)\n/)[1]},
        ch.match(/divisible by (.*)/)[1].to_i,
        ch.match(/true: throw to monkey (.*)/)[1].to_i,
        ch.match(/false: throw to monkey (.*)/)[1].to_i,
    ]
    b.add_monkey(inp)
end

#part 1
p b.reset(3).round(20).map(&:count).max(2).inject(&:*)

#part 2
p b.reset(1).round(10000).map(&:count).max(2).inject(&:*)

__END__
Monkey 0:
  Starting items: 79, 98
  Operation: new = old * 19
  Test: divisible by 23
    If true: throw to monkey 2
    If false: throw to monkey 3

Monkey 1:
  Starting items: 54, 65, 75, 74
  Operation: new = old + 6
  Test: divisible by 19
    If true: throw to monkey 2
    If false: throw to monkey 0

Monkey 2:
  Starting items: 79, 60, 97
  Operation: new = old * old
  Test: divisible by 13
    If true: throw to monkey 1
    If false: throw to monkey 3

Monkey 3:
  Starting items: 74
  Operation: new = old + 3
  Test: divisible by 17
    If true: throw to monkey 0
    If false: throw to monkey 1
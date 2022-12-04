#!/usr/bin/env ruby

# https://adventofcode.com/2021/day/23
require "json"

PRODUCTION = true && false
source = PRODUCTION ? open('./input-23.txt') : DATA


data = source.readlines(chomp: true).
              map{|l|l.scan(/[A-D]/).map{|c|c.ord-"A".ord}}.
              reject(&:empty?).
              transpose.flatten

#############
#ABCDEFGHIJK#
###L#N#P#R###
###M#O#Q#S###
#############

config =  (0..3).map{|i| [data.index(i)+'L'.ord,data.rindex(i)+'L'.ord]}.
                flatten.map(&:chr).join

def room_source(cfg)

end

__END__
#############
#01.2.3.4.56#
###B#C#B#D###
  #A#D#C#A#
  #########

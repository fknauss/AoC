#!/usr/bin/env ruby

#https://adventofcode.com/2020/day/34

PRODUCTION = true #&& false
source = PRODUCTION ? open('./input-04.txt') : DATA

data=source.readlines().join("").split(/\n\n/)
data.map!{|v| v.scan(/(\w+):(#?\w+)/).to_h}

# part 1
keys = %w(byr iyr eyr hgt hcl ecl pid).sort #cid
r = data.filter{|l|keys-l.keys==[]}
p r.count()

# part

r.filter! do |rec|

  byr = rec['byr'].to_i
  next false unless (1920..2002).include?(byr)

  iyr = rec['iyr'].to_i
  next false unless (2010..2020).include?(iyr)

  eyr = rec['eyr'].to_i
  next false unless (2020..2030).include?(eyr)

  hgt = rec['hgt']
  h1 = hgt =~ /^\d*cm$/ && (150..193).include?(hgt.to_i)
  h2 = hgt =~ /^\d*in$/ && (59..76).include?(hgt.to_i)
  next false unless(h1 || h2)

  next false unless /^#[0-9a-f]{6}$/ =~ rec['hcl']
  next false unless %w(amb blu brn gry grn hzl oth).include?(rec["ecl"])

  next false unless /^\d{9}$/ =~ rec['pid']

  true
end
p r.length


__END__
ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
byr:1937 iyr:2020 cid:147 hgt:183cm

iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
hcl:#cfa07d byr:1929

hcl:#ae17e1 iyr:2013
eyr:2024
ecl:brn pid:760753108 byr:1931
hgt:179cm

hcl:#cfa07d eyr:2025 pid:166559648
iyr:2011 ecl:brn hgt:59in

# frozen_string_literal: true

require 'mustache'
require 'pry'
file = File.open('./autogen/formats_wiki')

lines = file.readlines

config = {}

def maybe_inc_second(arr)
  [arr[0], arr[1] ? arr[1] + 1 : arr[1]]
end

def subregex(bban, indexes)
  return nil if indexes[0].nil?

  bban_part = bban[indexes[0]..indexes[1]]

  mapping = {
    n: '\d',
    a: '[A-Z]',
    c: '[a-zA-Z0-9]',
  }

  all_sings_are_the_same = bban_part.chars.all? { |c| c == bban_part[0] }
  return "#{mapping[bban_part[0].to_sym]}{#{bban_part.length}}" if all_sings_are_the_same

  bban_part.split('').map do |x|
    (mapping[x.to_sym]).to_s
  end.join
end

def add_new_country_to_config(line)
  match = /^(?<name>[a-zÀ-ž\s,]+)\s*(?<garbage>\[.*\])*\s*(?<len>\d+)\s*(?<bban_format>(?:\d{1,2}[a-z],*\s*)+)\s*(?<iban_format>(?:[a-z\d]{1,4}\s*)+)\s+(?<rest>\w+\s=.*)/i.match(line)
  unless match
    return if line.strip.length.zero?
    raise "Regex workn't"
  end
  name = match['name'].strip
  bban_format = match['bban_format'].gsub(/\s+/, '')
  iban_format = match['iban_format'].gsub(/\s+/, '')
  len = match['len'].to_i
  if iban_format.length != len
    raise "Lengths don't match, should be: #{len} but is #{iban_format.length}, iban_format: #{iban_format}"
  end

  country_code = iban_format[0...2]

  bban_format_spread = '____' + bban_format.split(',').map do |x|
    x.match(/(\d+)([a-z])/)
    Regexp.last_match(2).to_s * Regexp.last_match(1).to_i
  end.join

  get_indexes = ->(x) { [iban_format.index(x), iban_format.rindex(x)] }

  parts = {
    bank_code: 'b',
    branch_code: 's',
    checksum: 'x',
    account_number: 'c',
    account_type: 't',
    owner_account_number: 'n',
    currency_code: 'm',
    zero: '0',
    kennitala: 'i',
    account_prefix: 'p',
    bic: 'q',
    balance_account_number: 'a',
  }
  indexes = parts.keys.map do |k|
    [k, get_indexes.call(parts[k])]
  end.to_h

  regexes = parts.keys.map do |k|
    [k, subregex(bban_format_spread, indexes[k])]
  end.to_h
  parts_as_arr = parts.keys.map do |k|
    !regexes[k].nil? ? k : nil
  end.compact
  parts_in_order = parts.keys.map do |k|
    next if regexes[k].nil?

    {
      part: k,
      indexes: indexes[k],
      regex: regexes[k],
    }
  end.compact.sort_by { |x| x[:indexes][0] }
  const_global_checksum = {
    BA: '39',
    TL: '38',
    MK: '07',
    MR: '13',
    ME: '25',
    PT: '50',
    RS: '35',
    TN: '59',
  }

  # c = Account number preceded by zeros, if required - Saudi Arabia
  #
  # CONST global checksum - Bosnia and ... & East timor &b North Macedionia & Mauritania & Montenegro & Portugal & Slovenia & Tunisia
  #
  # b = BIC bank code Bulgaria & Giblartar & Latvia & Mauritania & Netherlands & Romania & UK
  # b = Bank and branch identifier (Bankleitzahl or BLZ) - Deutsch
  regex = country_code + '\d\d' + bban_format.split(',').map do |x|
    x.match(/(\d+)([a-z])/)
    mapping = {
      n: '\d',
      a: '[A-Z]',
      c: '[a-zA-Z0-9]',
    }
    "#{mapping[Regexp.last_match(2).to_sym]}{#{Regexp.last_match(1)}}"
  end.join
  {
    country_code => {
      country_name: name,
      country_code: country_code,
      bban_format: bban_format,
      iban_length: len,
      regex: regex,
      parts: "%w[#{parts_as_arr.join(" ")}]",
      const_global_checksum: const_global_checksum[country_code.to_sym],
      parts_in_order: parts_in_order,
      **parts.keys.map do |k|
        ["#{k}_indexes".to_s, maybe_inc_second(indexes[k])]
      end.to_h,
      **parts.keys.map do |k|
        ["#{k}_regex".to_s, regexes[k]]
      end.to_h,
    },
  }
end

def add_line_to_config(_line)
  nil
end

def parse_line(line)
  if line[/^\w\s=\s/i]
    add_line_to_config(line)
  else
    add_new_country_to_config(line)
  end
end

lines.each do |line|
  parsed = parse_line(line)
  config.merge!(parsed) if parsed
end
puts config
puts config.values
puts File.write('./lib/ibanana/country_config.rb',
                Mustache.render(File.read('./autogen/template.mustache'), { countries: config.values }))

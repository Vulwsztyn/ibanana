require "mustache"
require 'pry'
file = File.open("./autogen/formats_wiki")

lines = file.readlines

last_country_code = nil

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
  if all_sings_are_the_same
    return "#{mapping[bban_part[0].to_sym]}{#{bban_part.length}}"
  end
  bban_part.split('').map do |x|
    "#{mapping[x.to_sym]}"
  end.join
end

def add_new_country_to_config(line)
  match = /^(?<name>[a-zÀ-ž\s,]+)\s*(?<garbage>\[.*\])*\s*(?<len>\d+)\s*(?<bban_format>(?:\d{1,2}[a-z],*\s*)+)\s*(?<iban_format>(?:[a-z\d]{1,4}\s*)+)\s+(?<rest>\w+\s=.*)/i.match(line)
  unless match
    if line.strip.length == 0
      return
    else
      raise "Regex workn't"
    end
  end
  name = match['name'].strip
  bban_format = match['bban_format'].gsub(/\s+/, '')
  iban_format = match['iban_format'].gsub(/\s+/, '')
  len = match['len'].to_i
  if iban_format.length != len
    raise "Lengths don't match, should be: #{len} but is #{iban_format.length}, iban_format: #{iban_format}"
  end
  country_code = iban_format[0...2]

  bban_format_spread = '____'+bban_format.split(',').map do |x|
    x.match /(\d+)([a-z])/
    "#{$2}" * $1.to_i
  end.join

  get_indexes = -> x {[iban_format.index(x), iban_format.rindex(x)]}

  national_bank_code_indexes = get_indexes.call('b')
  branch_code_indexes = get_indexes.call('s')
  national_checksum_indexes = get_indexes.call('x')
  account_number_indexes = get_indexes.call('c')
  account_type_indexes = get_indexes.call('t')
  owner_account_number_indexes = get_indexes.call('n')
  currency_code_indexes = get_indexes.call('m')
  zero_indexes = get_indexes.call('0')
  kennitala_indexes = get_indexes.call('i')
  account_prefix_indexes = get_indexes.call('p')
  bic_indexes = get_indexes.call('q')
  balance_account_number_indexes = get_indexes.call('a')

  national_bank_code_regex = subregex(bban_format_spread, national_bank_code_indexes)
  branch_code_regex = subregex(bban_format_spread, branch_code_indexes)
  national_checksum_regex = subregex(bban_format_spread, national_checksum_indexes)
  account_number_regex = subregex(bban_format_spread, account_number_indexes)
  account_type_regex = subregex(bban_format_spread, account_type_indexes)
  owner_account_number_regex = subregex(bban_format_spread, owner_account_number_indexes)
  currency_code_regex = subregex(bban_format_spread, currency_code_indexes)
  zero_regex = subregex(bban_format_spread, zero_indexes)
  kennitala_regex = subregex(bban_format_spread, kennitala_indexes)
  account_prefix_regex = subregex(bban_format_spread, account_prefix_indexes)
  bic_regex = subregex(bban_format_spread, bic_indexes)
  balance_account_number_regex = subregex(bban_format_spread, balance_account_number_indexes)

  parts = []
  parts << 'bank_code' if national_bank_code_regex
  parts << 'branch_code' if branch_code_regex
  parts << 'checksum' if national_checksum_regex
  parts << 'account_number' if account_number_regex
  parts << 'account_type' if account_type_regex
  parts << 'owner_account_number' if owner_account_number_regex
  parts << 'currency_code' if currency_code_regex
  # parts << 'zero' if zero_regex
  parts << 'kennitala' if kennitala_regex
  parts << 'account_prefix' if account_prefix_regex
  parts << 'bic' if bic_regex
  parts << 'balance_account_number' if balance_account_number_regex

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
  regex = country_code+'\d\d'+bban_format.split(',').map do |x|
    x.match /(\d+)([a-z])/
    mapping = {
      n: '\d',
      a: '[A-Z]',
      c: '[a-zA-Z0-9]',
    }
    "#{mapping[$2.to_sym]}{#{$1}}"
  end.join
  {
    country_code => {
      country_name: name,
      country_code: country_code,
      bban_format: bban_format,
      has_national_bank_code: !national_bank_code_indexes[0].nil?,
      national_bank_code_indexes: maybe_inc_second(national_bank_code_indexes),
      national_bank_code_regex: national_bank_code_regex,
      has_branch_code: !branch_code_indexes[0].nil?,
      branch_code_indexes: maybe_inc_second(branch_code_indexes),
      branch_code_regex: branch_code_regex,
      has_national_checksum: !national_checksum_indexes[0].nil?,
      national_checksum_indexes: maybe_inc_second(national_checksum_indexes),
      national_checksum_regex: national_checksum_regex,
      has_account_number: !account_number_indexes[0].nil?,
      account_number_indexes: maybe_inc_second(account_number_indexes),
      account_number_regex: account_number_regex,
      has_account_type: !account_type_indexes[0].nil?,
      account_type_indexes: maybe_inc_second(account_type_indexes),
      account_type_regex: account_type_regex,
      has_owner_account_number: !owner_account_number_indexes[0].nil?,
      owner_account_number_indexes: maybe_inc_second(owner_account_number_indexes),
      owner_account_number_regex: owner_account_number_regex,
      has_currency_code: !currency_code_indexes[0].nil?,
      currency_code_indexes: maybe_inc_second(currency_code_indexes),
      currency_code_regex: currency_code_regex,
      has_zero: !zero_indexes[0].nil?,
      zero_indexes: maybe_inc_second(zero_indexes),
      zero_regex: zero_regex,
      has_kennitala: !kennitala_indexes[0].nil?,
      kennitala_indexes: maybe_inc_second(kennitala_indexes),
      kennitala_regex: kennitala_regex,
      has_account_prefix: !account_prefix_indexes[0].nil?,
      account_prefix_indexes: maybe_inc_second(account_prefix_indexes),
      account_prefix_regex: account_prefix_regex,
      has_bic: !bic_indexes[0].nil?,
      bic_indexes: maybe_inc_second(bic_indexes),
      bic_regex: bic_regex,
      has_balance_account_number: !balance_account_number_indexes[0].nil?,
      balance_account_number_indexes: maybe_inc_second(balance_account_number_indexes),
      balance_account_number_regex: balance_account_number_regex,
      iban_length: len,
      regex: regex,
      parts: '%w['+parts.join(' ')+']',
      const_global_checksum: const_global_checksum[country_code.to_sym],
    } }
end

def add_line_to_config(line)
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
puts File.write("./lib/ibanana/country_config.rb", Mustache.render(File.read("./autogen/template.mustache"), { countries: config.values }))
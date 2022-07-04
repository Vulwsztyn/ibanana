class IbanHelper
  class << self
    def get_country_code(iban)
      iban[0...2]
    end

    def get_global_checksum(iban)
      iban[2...4]
    end

    def get_bban(iban)
      # TODO check name correctness
      iban[4...]
    end

    def get_part(iban, part)
      country = get_country_code(iban)
      indexes = CountryConfig[country.to_sym][part.to_sym]
      if indexes
        iban[indexes[0]...indexes[1]]
      else
        raise "Country: #{country} doesn't have part: #{part} "
      end
    end

    def method_missing(name_as_symbol, iban, *args, **kwargs)
      name = name_as_symbol.to_s
      binding.pry
      match = name.match(/^get_(.*)/)
      if match
        part = match[1]
        get_part(iban, part)
      end
      puts args, kwargs
    end

    def to_hexatrigesimal(chr)
      if '0' <= chr && chr <= '9'
        chr
      elsif 'A' <= chr && chr <= 'Z'
        (chr.ord - 'A'.ord + 10).to_s
      else
        raise "This should not happen as Iban should already be validated to contain proper chars."
      end
    end
  end
end
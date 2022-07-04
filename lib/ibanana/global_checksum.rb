
def global_validate(iban)
    transformed_number = IbanHelper.get_bban(iban) + IbanHelper.get_country_code(iban)
    checksum = IbanHelper.get_global_checksum(iban)
    calculate_checksum(transformed_number)
      .bind { |x| x == checksum ? Success(iban) : Failure("#{iban}: Niepoprawna suma kontrolna - #{checksum}. Powinna być #{x}") }
  end

  def calculate_checksum(number)
    number
      .split('')
      .map { |chr| to_hexatrigesimal(chr) }
      .join('')
      .to_i
      .then { |x| x * 100 }
      .then { |x| 98 - (x % 97) }
      .then { |x| format('%02d', x) }
  end
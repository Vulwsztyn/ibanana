class Checksums
  class << self
    def global(iban)
      x = IbanHelper.get_bban(iban) + IbanHelper.get_country_code(iban)
      x
        .split('')
        .map { |chr| to_hexatrigesimal(chr) }
        .join('')
        .to_i
        .then { |x| x * 100 }
        .then { |x| 98 - (x % 97) }
        .then { |x| format('%02d', x) }
    end

    def local(iban)
      procs = {
        AL: -> x { albania_calculate(x) },
        BE: -> x { belgium_calculate(x) },
        BA: -> x { Success(x) }, # it only exists so that the global checksum is 39
        HR: -> x { croatia_calculate(x) },
        CZ: -> x { czech_calculate(x) },
        TL: -> x { east_timor_calculate(x) },
        EE: -> x { estonia_calculate(x) },
        FI: -> x { finland_calculate(x) },
        FR: -> x { france_calculate(x) },
        HU: -> x { hungary_calculate(x) },
        IS: -> x { iceland_calculate(x) },
        IT: -> x { italy_calculate(x) },
        MK: -> x { north_macedonia_calculate(x) },
        MR: -> x { mauritania_calculate(x) },
        MC: -> x { france_calculate(x) }, # Monaco uses the same algorithm as France
        ME: -> x { montenegro_calculate(x) },
        NO: -> x { norway_calculate(x) },
        PL: -> x { poland_calculate(x) },
        PT: -> x { portugal_calculate(x) },
        SM: -> x { italy_calculate(x) }, # San Marino uses the same algorithm as Italy
        RS: -> x { serbia_calculate(x) },
        SK: -> x { czech_calculate(x) }, # Slovakia uses the same algorithm as Czechia
        SI: -> x { slovenia_calculate(x) },
        ES: -> x { spain_calculate(x) },
        TN: -> x { tunisia_calculate(x) },
      }
      country_code = get_country_code(iban).to_sym
      procs.key?(country_code) ? procs[country_code].call(iban) : Success
    end

    def generic_local_checksum(iban, parts, calculation_fn)
      get_iban_parts(iban, parts).then { |x| calculation_fn.call(x) }
    end

    def weighted(text, weights, modulo, postproc, prezip: -> x { x }, presum: -> x { x })
      text
        .split('')
        .map(&:to_i)
        .then { |x| prezip.call(x) }
        .zip(weights.cycle)
        .map { |num, weight| num * weight }
        .then { |x| presum.call(x) }
        .sum
        .then { |x| x % modulo }
        .then { |x| postproc.call(x) }
    end

    def iso7064_mod97_10(text, modulo: 97, minuend: 98, premod: -> x { x * 100 })
      text
        .to_i
        .then { |x| premod.call(x) }
        .then { |x| x % modulo }
        .then { |x| minuend - x }
    end

    def get_iban_parts(iban, parts, concat_fn: -> x, y { x + y })
      getters = {
        bank_code: -> x { get_bank_code(x) },
        branch_code: -> x { get_branch_code(x) },
        account_number: -> x { get_account_number(x) },
      }
      parts
        .map { |x| getters[x.to_sym].call(iban) }
        .then { |x| concat_results(x, concat_fn: concat_fn) }
    end

    def albania_calculate(iban)
      generic_local_checksum(
        iban,
        ['bank_code', 'branch_code'],
        -> x { weighted(x, [9, 7, 3, 1, 9, 7, 3, 1], 10, -> y { y == 0 ? 0 : 10 - y }) }
      )
    end

    def belgium_calculate(iban)
      generic_local_checksum(
        iban,
        ['bank_code', 'account_number'],
        -> x { (x.to_i % 97).then { |x| x == 0 ? 97 : x } }
      )
    end

    def croatia_calculate(iban)
      def mod_10_11(acc, num)
        sum = acc + num
        subtotal = sum % 10 == 0 ? 10 : sum % 10
        (subtotal * 2) % 11
      end

      calculate = -> x do
        y = x.split('').inject(10) { |acc, num| mod_10_11(acc, num.to_i) }
        y == 1 ? 0 : 11 - y
      end

      calculated_checksum_bank_code = generic_local_checksum(iban, ['bank_code'], calculate)
      calculated_checksum_acc_number = generic_local_checksum(iban, ['account_number'], calculate)

      bank_matches = compare_results(calculated_checksum_bank_code, Success(9))
      acc_matches = compare_results(calculated_checksum_acc_number, Success(9))

      concat_results([bank_matches, acc_matches], concat_fn: -> _, _ { true }).either(-> _ { Success(iban) }, -> x { Failure("#{x} #{iban}") })
    end

    def czech_calculate(iban)
      calculated_checksum_acc_number = get_account_number(iban)
                                         .fmap { |x| weighted(x, [6, 3, 7, 9, 10, 5, 8, 4, 2, 1], 11, -> y { y == 0 ? 0 : 11 - y }) }
      calculated_checksum_branch_number = get_branch_code(iban)
                                            .fmap { |x| weighted(x, [10, 5, 8, 4, 2, 1], 11, -> y { y == 0 ? 0 : 11 - y }) }
      acc_matches = compare_results(calculated_checksum_acc_number, Success(0))
      branch_matches = compare_results(calculated_checksum_branch_number, Success(0))
      concat_results([acc_matches, branch_matches], concat_fn: -> _, _ { true }).either(-> _ { Success(iban) }, -> x { Failure("#{x} #{iban}") })
    end

    def east_timor_calculate(iban)
      generic_local_checksum(
        iban,
        ['bank_code', 'account_number'],
        -> x { iso7064_mod97_10(x) }
      )
    end

    def estonia_calculate(iban)
      generic_local_checksum(
        iban,
        ['branch_code', 'account_number'],
        -> x { weighted(x, [7, 3, 1], 10, -> y { y == 0 ? 0 : 10 - y }, prezip: -> y { y.reverse }) }
      )
    end

    def finland_calculate(iban)
      generic_local_checksum(
        iban,
        ['bank_code', 'account_number'],
        -> x { weighted(x, [2, 1], 10, -> y { y == 0 ? 0 : 10 - y }, presum: -> y { y.map { |num| num % 10 + num / 10 } }) }
      )
    end

    def france_calculate(iban)
      def french_letter_to_digit(letter)
        return letter.to_i if letter[/^\d$/]
        if letter <= 'I'
          letter.ord - 'A'.ord + 1 # A-I => 1-9
        elsif letter <= 'R'
          letter.ord - 'I'.ord # J-R => 1-9
        else
          letter.ord - 'R'.ord + 1 # S-Z => 2-9
        end
      end

      calculated_checksum = get_bank_code(iban)
                              .bind { |x| get_branch_code(iban).either(-> y { Success([x, y]) }, -> y { Failure(y) }) }
                              .bind { |x| get_account_number(iban).either(-> y { Success(x + [y]) }, -> y { Failure(y) }) }
                              .fmap { |x| x.map { |e| e.split('') } }
                              .fmap { |x| x.map { |e| e.map { |l| french_letter_to_digit(l).to_s } } }
                              .fmap { |x| x.map(&:join) }
                              .fmap { |x| x.map(&:to_i) }
                              .fmap { |x| x.zip([89, 15, 3]) } # no idea where these come from
                              .fmap { |x| x.map { |num, weight| num * weight } }
                              .fmap(&:sum)
                              .fmap { |x| iso7064_mod97_10(x, minuend: 97, premod: -> x { x }) }

      compare_to_local_checksum(iban, calculated_checksum)
    end

    def hungary_calculate(iban)
      calculate = -> x { weighted(x, [9, 7, 3, 1], 10, -> y { y == 0 ? 0 : 10 - y }) }
      calculated_checksum_bank_code = get_iban_parts(iban, ['bank_code', 'branch_code']).fmap { |x| calculate.call(x) }
      calculated_checksum_branch_number = get_account_number(iban).fmap { |x| calculate.call(x) }
      national_checksum = get_local_checksum(iban) # this is not technically correct since they are not consecutive - HUkk bbbs sssX cccc cccc cccc cccX

      return national_checksum if national_checksum.failure?

      bank_code_checksum = national_checksum.value![0]
      branch_number_checksum = national_checksum.value![-1]
      bank_code_matches = calculated_checksum_bank_code.bind { |x| x == bank_code_checksum.to_i ? Success(x) : Failure("Niepoprawna suma kontrolna1 - #{x}. Powinna być #{bank_code_checksum}.") }
      branch_matches = calculated_checksum_branch_number.bind { |x| x == branch_number_checksum.to_i ? Success(x) : Failure("Niepoprawna suma kontrolna2 - #{x}. Powinna być #{branch_number_checksum}.") }
      if bank_code_matches.failure? || branch_matches.failure?
        return Failure(bank_code_matches.either(-> _ { branch_matches }, -> y { branch_matches.either(-> z { Failure(y) }, -> z { Failure([y, z, iban]) }) }))
      end
      Success(iban)
    end

    def iceland_calculate(iban)
      kennitala = get_part_of_iban(iban, 'kennitala')
      calculated_checksum = kennitala
                              .fmap { |x| x[0...8] }
                              .fmap { |x| weighted(x, [3, 2, 7, 6, 5, 4, 3, 2], 11, -> y { y == 0 ? 0 : 11 - y }) }
      checksum = kennitala.fmap { |x| x[8].to_i }
      calculated_checksum.bind { |x| checksum.value! == x ? Success(iban) : Failure("Niepoprawna suma kontrolna - #{checksum}. Powinna być #{calculated_checksum.value!}: #{iban}") }
    end

    def italy_calculate(iban)
      def odd_map(letter)
        digit_map = [1, 0, 5, 7, 9, 13, 15, 17, 19, 21]
        letter_map = [1, 0, 5, 7, 9, 13, 15, 17, 19, 21, 2, 4, 18, 20, 11, 3, 6, 8, 12, 14, 16, 10, 22, 25, 24, 23]
        if letter[/^\d$/]
          digit_map[letter.to_i]
        else
          letter_map[letter.ord - 'A'.ord]
        end
      end

      def even_map(letter)
        if letter[/^\d$/]
          letter.to_i
        else
          letter.ord - 'A'.ord
        end
      end

      calculated_checksum = get_bank_code(iban)
                              .bind { |x| get_branch_code(iban).either(-> y { Success(x + y) }, -> y { Failure(y) }) }
                              .bind { |x| get_account_number(iban).either(-> y { Success(x + y) }, -> y { Failure(y) }) }
                              .fmap { |x| x.split('') }
                              .fmap { |x| x.each_with_index.map { |chr, i| (i + 1).even? ? even_map(chr) : odd_map(chr) } }
                              .fmap(&:sum)
                              .fmap { |x| x % 26 }
                              .fmap { |x| ('A'.ord + x).chr }
      calculated_checksum.bind { |x| get_local_checksum(iban).either(-> y { x == y ? Success(iban) : Failure("Niepoprawna suma kontrolna - #{y}. Powinna być #{x}: #{iban}") }, -> y { Failure(y) }) }
    end

    def north_macedonia_calculate(iban)
      generic_local_checksum(
        iban,
        ['bank_code', 'account_number'],
        -> x { iso7064_mod97_10(x) }
      )
    end

    def mauritania_calculate(iban)
      generic_local_checksum(
        iban,
        ['bank_code', 'branch_code', 'account_number'],
        -> x { iso7064_mod97_10(x, minuend: 97) }
      )
    end

    def montenegro_calculate(iban)
      generic_local_checksum(
        iban,
        ['bank_code', 'account_number'],
        -> x { iso7064_mod97_10(x) }
      )
    end

    def norway_calculate(iban)
      calculated_checksum = get_bank_code(iban)
                              .bind { |x| get_account_number(iban).either(-> y { Success([x, y]) }, -> y { Failure(y) }) }
                              .fmap { |x, y| y.start_with?('00') ? y[2..] : x + y }
                              .fmap { |x| weighted(x, [5, 4, 3, 2, 7, 6, 5, 4, 3, 2], 11, -> y { y == 0 ? 0 : 11 - y }) } # TODO 1 - invalid
      compare_to_local_checksum(iban, calculated_checksum)
    end

    def poland_calculate(iban)
      generic_local_checksum(
        iban,
        ['bank_code', 'branch_code'],
        -> x { weighted(x, [3, 9, 7, 1], 10, -> y { y == 0 ? 0 : 10 - y }) }
      )
    end

    def portugal_calculate(iban)
      generic_local_checksum(
        iban,
        ['bank_code', 'branch_code', 'account_number'],
        -> x { iso7064_mod97_10(x) }
      )
    end

    def serbia_calculate(iban)
      generic_local_checksum(
        iban,
        ['bank_code', 'account_number'],
        -> x { iso7064_mod97_10(x) }
      )
    end

    def slovenia_calculate(iban)
      generic_local_checksum(
        iban,
        ['bank_code', 'branch_code', 'account_number'],
        -> x { iso7064_mod97_10(x) }
      )
    end

    def spain_calculate(iban)
      calculate = -> weights, x { weighted(x, weights, 11, -> y { y <= 1 ? y : 11 - y }) }
      calculated_checksum_bank_code = get_iban_parts(iban, ['bank_code', 'branch_code'])
                                        .fmap { |x| calculate.call([4, 8, 5, 10, 9, 7, 3, 6], x) }
      calculated_checksum_acc_number = get_account_number(iban)
                                         .fmap { |x| calculate.call([1, 2, 4, 8, 5, 10, 9, 7, 3, 6], x) }
      national_checksum = get_local_checksum(iban)

      return national_checksum if national_checksum.failure?

      bank_code_checksum = national_checksum.value![0]
      acc_number_checksum = national_checksum.value![-1]
      bank_code_matches = calculated_checksum_bank_code.bind { |x| x == bank_code_checksum.to_i ? Success(x) : Failure("ES1Niepoprawna suma kontrolna - #{x}. Powinna być #{bank_code_checksum}.") }
      branch_matches = calculated_checksum_acc_number.bind { |x| x == acc_number_checksum.to_i ? Success(x) : Failure("ES2Niepoprawna suma kontrolna - #{x}. Powinna być #{acc_number_checksum}.") }
      # TODO - combaing failures
      if bank_code_matches.failure? || branch_matches.failure?
        return Failure(bank_code_matches.either(-> _ { branch_matches }, -> y { branch_matches.either(-> z { Failure(y) }, -> z { Failure([y, z, iban]) }) }))
      end
      Success(iban)
    end

    def tunisia_calculate(iban)
      generic_local_checksum(
        iban,
        ['bank_code', 'branch_code', 'account_number'],
        -> x { iso7064_mod97_10(x, minuend: 97) }
      )
    end
  end
end
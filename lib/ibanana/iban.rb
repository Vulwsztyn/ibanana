# frozen_string_literal: true

require 'dry/monads'

class Iban

  include Dry::Monads[:result]

  def initialize(iban)
    @states = {
      not_validated: 0,
      is_string: 1,
      has_country: 2,
      has_valid_length: 3,
      has_valid_format: 4,
      has_valid_global_checksum: 5,
      has_valid_local_checksum: 6,
    }

    @data = Success({ state: @states[:not_validated],
                      iban: iban, })

    @errors = {
      not_a_string: 'not_a_string',
      does_not_start_with_country_prefix: 'does_not_start_with_country_prefix',
      not_an_iban_country: 'not_an_iban_country',
      invalid_length_for_the_country: 'invalid_length_for_the_country',
      invalid_format_for_the_country: 'invalid_format_for_the_country',
      wrong_global_checksum: 'wrong_global_checksum',
      wrong_local_checksum: 'wrong_local_checksum',
    }
  end

  def human_readable
    ensure_state(@states[:string?]).fmap do |data|
      data[:iban].scan(/.{1,4}/).join(' ')
    end
  end

  private

  def ensure_state(state)
    return @data if @data.failure?
    return @data if @data.value![:state] == state

    transitions = {
      [@states[:not_validated]] => -> { string? },
    }
    @data = @data.bind do |data|
      transitions[[data[:state]]].call
    end
  end

  def string?
    iban = @data[:iban]
    if iban.is_a?(String)
      Success({ state: @states[:is_string],
                iban: iban.gsub(/\s+/, '').upcase, })
    else
      Failure({ error: @errors[:not_a_string] })
    end
  end

  def country?()
    iban = @data[:iban]
    if iban[/^[A-Z]{2}/]
      Success({ state: @states[:has_country],
                iban: iban, })
    else
      Failure({ error: @errors[:does_not_start_with_country_prefix] })
    end
  end

  def valid_length?
    iban = @data[:iban]
    country = IbanHelper.get_country_code(iban)
    config = CountryConfig.config[country.to_sym]
    return Failure({ error: @errors[:not_an_iban_country], metadata: { country: country } }) if config.nil?
    expected_length = config.length
    if iban.length == expected_length
      Success({
                state: @states[:has_valid_length],
                iban: iban,
                country: country,
                config: config,
              })
    else
      Failure({ error: @errors[:invalid_length_for_the_country], metadata: { country: country, length: iban.length, expected_length: expected_length } })
    end
  end

  def valid_format?
    regex = @data[:config].regex
    if @data[:iban][Regexp.new(regex)]
      Success({
                state: @states[:has_valid_format],
                **@data
              })
    else
      # TODO add info t metadata both global and parts
      Failure({ error: @errors[:invalid_format_for_the_country] })
    end
  end

  def globally_valid?
    iban = @data[:iban]
    expected_checksum = Checksums.global(iban)
    actual_checksum = IbanHelper.get_global_checksum(iban)
    if expected_checksum == actual_checksum
      Success({
        state: @states[:has_valid_global_checksum],
        **@data
      })
    else 
      Failure({ error: @errors[:wrong_global_checksum], metadata: {expected: expected_checksum, actual: actual_checksum} })
    end
  end

  def locally_valid?
    # TODO: implement
    iban = @data[:iban]
    expected_checksum = Checksums.global(iban)
    actual_checksum = IbanHelper.get_global_checksum(iban)
    if expected_checksum == actual_checksum
      Success({
        state: @states[:has_valid_global_checksum],
        **@data
      })
    else 
      Failure({ error: @errors[:wrong_global_checksum], metadata: {expected: expected_checksum, actual: actual_checksum} })
    end
  end
  
end

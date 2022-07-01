require 'dry/monads'

class Iban
  @@states = {
    not_validated: 0,
    is_string: 1,
    has_valid_length: 2,
    has_valid_format: 3,
    has_valid_global_checksum: 4,
    has_valid_local_checksum: 5,
  }

  include Dry::Monads[:result]

  def initialize(iban)
    @data = Success({ state: @@states[:not_validated],
                      iban: iban.gsub(/\s+/, "")
                    })
  end

  def human_readable
    ensure_state(@@states[:is_string]).fmap do |data|
      data[:iban].scan(/.{1,4}/).join(" ")
    end
  end

  private

  def ensure_state(state)

    return @data if @data.failure?
    return @data if @data.value![:state] == state
    transitions = {
      [@@states[:not_validated]] => ->(iban) { is_string(iban) }
    }
    @data = @data.bind do |data|
      transitions[[data[:state]]].call(data[:iban])
    end
  end

  def is_string(iban)
    iban.is_a?(String) ? Success({ state: @@states[:is_string], iban: iban }) : Failure("Supplied IBAN #{iban} is not a String")
  end
end
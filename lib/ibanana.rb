# frozen_string_literal: true

require_relative "ibanana/version"
require_relative 'ibanana/ibanana'
require 'dry/monads'

module Ibanana
  Iban = ::Iban
end

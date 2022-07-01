# frozen_string_literal: true

require "test_helper"
require 'dry/monads'

class TestIbanana < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Ibanana::VERSION
  end

  def test_it_formats_correctly
    x = Ibanana::Iban.new("1234ABCD5678")
    q = x.human_readable
    assert q.success?
    assert_equal "1234 ABCD 5678", q.value!
  end
end

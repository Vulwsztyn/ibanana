# frozen_string_literal: true

require 'test_helper'
require 'dry/monads'
require 'pry'

class TestIbanana < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Ibanana::VERSION
  end

  def test_it_formats_correctly
    iban = Ibanana::Iban.new('1234ABCD5678Y')
    text = iban.human_readable
    assert text.success?
    assert_equal '1234 ABCD 5678 Y', text.value!
  end

  def test_it_errors_on_not_a_string
    binding.pry

    [1, nil, :asd, {}, []].each do |x|
      iban = Ibanana::Iban.new(x)
      text = iban.human_readable
      assert text.failure?
      assert_equal [{ error: 'not_a_string' }], text.failure
    end
  end
end

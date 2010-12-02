require "test/unit"

$:.unshift File.join(File.dirname(__FILE__), *%w[.. lib])
require 'macronconversions/macronconversions'

class TestLibraryFileName < Test::Unit::TestCase
  def test_case_name
    assert(true, "Failure message.")
  end
end
require "test/unit"

$:.unshift File.join(File.dirname(__FILE__), *%w[.. lib])
require 'macronconversions/macronconversions'

puts 'holey moley '
class TestLibraryFileName < Test::Unit::TestCase
  def testZebu
    assert(true, "Failure message.")
  end
end
require "test/unit"

$:.unshift File.join(File.dirname(__FILE__), *%w[.. lib])
require 'macronconversions/macronconversions'

class TestLibraryFileName < Test::Unit::TestCase
  def testLatexToMacrons
    assert(true, "Failure message.")
    Text::LatTeX::Util::Macronconversions::razzle()
  end
end
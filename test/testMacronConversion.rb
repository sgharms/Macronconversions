require "test/unit"

$:.unshift File.join(File.dirname(__FILE__), *%w[.. lib])
require 'macronconversions/macronconversions'

class TestLibraryFileName < Test::Unit::TestCase
  def testLatexToMacrons
    assert_equal "expected", Text::LatTeX::Util::Macronconversions.convert("mon\\={e}re", 'mc')
    assert_equal "another",  Text::LatTeX::Util::Macronconversions.convert('to bring up, educate: \={e}duc\={o}, \={e}duc\={a}re, \={e}duc\={a}v\={\i}, \={e}ducatus; education, educator, educable', 'mc')
  end
end
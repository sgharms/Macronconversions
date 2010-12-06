# coding: utf-8
require "test/unit"

$:.unshift File.join(File.dirname(__FILE__), *%w[.. lib])
require 'macronconversions/macronconversions'

class TestMacronDeconversion < Test::Unit::TestCase
  def test_basic_mc_deconversion
    assert_equal "vanilla",      Text::Latex::Util::Macronconversions.deconvert("vanilla")
    assert_equal "laud\\={a}re", Text::Latex::Util::Macronconversions.deconvert("laudāre") 
    assert_equal "mon\\={e}re",  Text::Latex::Util::Macronconversions.deconvert("monēre")
  end
  def test_basic_utf8_deconversion
    assert_equal "laud\\={a}re", Text::Latex::Util::Macronconversions.deconvert("laud\\xc4\\x81re")    
  end
  def test_basic_html_deconversion
    assert_equal "laud\\={a}re", Text::Latex::Util::Macronconversions.deconvert("laud&#x101;re")
  end
end
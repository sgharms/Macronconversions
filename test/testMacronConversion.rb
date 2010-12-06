# coding: utf-8
require "test/unit"

$:.unshift File.join(File.dirname(__FILE__), *%w[.. lib])
require 'macronconversions/macronconversions'

class TestLibraryFileName < Test::Unit::TestCase
  def ctest_conversions
    assert_equal "expected", Text::LaTeX::Util::Macronconversions.convert("mon\\={e}re", 'mc')
    # assert_equal "another",  Text::LaTeX::Util::Macronconversions.convert('to bring up, educate: \={e}duc\={o}, \={e}duc\={a}re, \={e}duc\={a}v\={\i}, \={e}ducatus; education, educator, educable', 'mc')
  end                
  def test_character_conversion_mc
    assert_equal "ā", Text::LaTeX::Util::Macronconversions._convert_char("\\={a}"  ,:mc)
    assert_equal 'ē', Text::LaTeX::Util::Macronconversions._convert_char("\\={e}"  ,:mc)
    assert_equal "ī", Text::LaTeX::Util::Macronconversions._convert_char("\\={\\i}",:mc)
    assert_equal "ō", Text::LaTeX::Util::Macronconversions._convert_char("\\={o}"  ,:mc)
    assert_equal "ū", Text::LaTeX::Util::Macronconversions._convert_char("\\={u}"  ,:mc)
    assert_equal "Ā", Text::LaTeX::Util::Macronconversions._convert_char("\\={A}"  ,:mc)
    assert_equal "Ē", Text::LaTeX::Util::Macronconversions._convert_char("\\={E}"  ,:mc)
    assert_equal "Ī", Text::LaTeX::Util::Macronconversions._convert_char("\\={\\I}",:mc)
    assert_equal "Ō", Text::LaTeX::Util::Macronconversions._convert_char("\\={O}"  ,:mc)
    assert_equal "Ū", Text::LaTeX::Util::Macronconversions._convert_char("\\={U}"  ,:mc)    
  end
  def test_character_conversion_html
    assert_equal "&#x101;", Text::LaTeX::Util::Macronconversions._convert_char("\\={a}"  ,:html)
    assert_equal "&#x113;", Text::LaTeX::Util::Macronconversions._convert_char("\\={e}"  ,:html)
    assert_equal "&#x12b;", Text::LaTeX::Util::Macronconversions._convert_char("\\={\\i}",:html)
    assert_equal "&#x14d;", Text::LaTeX::Util::Macronconversions._convert_char("\\={o}"  ,:html)
    assert_equal "&#x16b;", Text::LaTeX::Util::Macronconversions._convert_char("\\={u}"  ,:html)
    assert_equal "&#x100;", Text::LaTeX::Util::Macronconversions._convert_char("\\={A}"  ,:html)
    assert_equal "&#x112;", Text::LaTeX::Util::Macronconversions._convert_char("\\={E}"  ,:html)
    assert_equal "&#x12a;", Text::LaTeX::Util::Macronconversions._convert_char("\\={\\I}",:html)
    assert_equal "&#x14c;", Text::LaTeX::Util::Macronconversions._convert_char("\\={O}"  ,:html)
    assert_equal "&#x16a;", Text::LaTeX::Util::Macronconversions._convert_char("\\={U}"  ,:html)        
  end
  def ctest_character_conversion_utf8
    assert_equal "\\xc4\\x81", Text::LaTeX::Util::Macronconversions._convert_char("\\={a}"  ,:utf8)
    assert_equal "\\xc4\\x93", Text::LaTeX::Util::Macronconversions._convert_char("\\={e}"  ,:utf8)
    assert_equal "\\xc4\\xab", Text::LaTeX::Util::Macronconversions._convert_char("\\={\\i}",:utf8)
    assert_equal "\\xc5\\x8d", Text::LaTeX::Util::Macronconversions._convert_char("\\={o}"  ,:utf8)
    assert_equal "\\xc5\\xab", Text::LaTeX::Util::Macronconversions._convert_char("\\={u}"  ,:utf8)
    assert_equal "\\xc4\\x80", Text::LaTeX::Util::Macronconversions._convert_char("\\={A}"  ,:utf8)
    assert_equal "\\xc4\\x92", Text::LaTeX::Util::Macronconversions._convert_char("\\={E}"  ,:utf8)
    assert_equal "\\xc4\\xaa", Text::LaTeX::Util::Macronconversions._convert_char("\\={\\I}",:utf8)
    assert_equal "\\xc5\\x8c", Text::LaTeX::Util::Macronconversions._convert_char("\\={O}"  ,:utf8)
    assert_equal "\\xc5\\xaa", Text::LaTeX::Util::Macronconversions._convert_char("\\={U}"  ,:utf8)        
  end
end
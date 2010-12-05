=begin rdoc
== Synopsis

Text::Latex::Util::MacronConversions:  module providing classes to convert
macron (dis-)enabled strings into the opposite.

== Usage

 require 'require macronconversions'

== Description

The class provides two classes: MacronConverter and MacronDeConverter.  In
the event that you need to transform LaTeX-style markep into entities of
some sort, use the former class.  In the event that you need to down-sample
macron-characters into LaTeX-style, use the latter.

== Example Code

  # Basic conversion and advanced conversion

  puts Text::LatTeX::Util::Macronconversions.convert("mon\\={e}re", 'mc')
  puts Text::LatTeX::Util::Macronconversions.convert('to bring up, educate: \={e}duc\={o}, \={e}duc\={a}re, \={e}duc\={a}v\={\i}, \={e}ducatus; education, educator, educable', 'mc')
  
  # Vanilla de-conversion
  puts MacronConversions::MacronDeConverter.new("vanilla")
  
  # Complex de-conversion
  puts MacronConversions::MacronDeConverter.new("laudāre")
  
  # Coup de grace
  puts MacronConversions::MacronDeConverter.new(
    MacronConversions::MacronConverter.new('to bring up, educate: \={e}duc\={o}, \={e}duc\={a}re, \={e}duc\={a}v\={\i}, \={e}ducatus; education, educator, educable', 'mc').to_s)

== Author     

Steven G. Harms, http://www.stevengharms.com        

=end

$:.unshift File.join(File.dirname(__FILE__), *%w[.. lib])
require 'macronconversions/macronconversions'
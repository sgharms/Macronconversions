=begin rdoc
== Synopsis

Text::Latex::Util::MacronConversions:  module providing class methods to convert
macron (dis-)enabled strings into the opposite.

== Usage

 require 'require macronconversions'

== Description

The class provides two class methods:  +convert+ and +deconvert+  In
the event that you need to transform LaTeX-style markep into entities of
some sort, use the former class.  In the event that you need to down-sample
macron-characters into LaTeX-style, use the latter.

== Example Code

  # Basic conversion and advanced conversion
  puts Text::Latex::Util::Macronconversions.convert("mon\\={e}re", 'mc') #=> monēre

  # Complex de-conversion
  puts MacronConversions::MacronDeConverter.new("laudāre") #=> "laud\={a}re"

  # Coup de grace
  puts MacronConversions::MacronDeConverter.new(
    MacronConversions::MacronConverter.new('to bring up, educate: \={e}duc\={o}, \={e}duc\={a}re, \={e}duc\={a}v\={\i}, \={e}ducatus; education, educator, educable', 'mc').to_s)

== Author     

Steven G. Harms, http://www.stevengharms.com        

=end
$:.unshift File.join(File.dirname(__FILE__), *%w[.. lib])
require 'macronconversions/macronconversions'    
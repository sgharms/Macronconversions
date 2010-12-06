# coding: utf-8
require 'macronconversions/conversion_structure'

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
# Module for manipulations on text documents
module Text
  # Module for working with LaTeX-formatted text
  module Latex
    # Utilities for generating LaTeX-formatted text
    module Util
      # == Synopsis
      # 
      # Text::Latex::Util::MacronConversions:  module providing class methods to convert
      # macron (dis-)enabled strings into the opposite.
      # 
      # == Usage
      # 
      #  require 'require macronconversions'
      # 
      # == Description
      # 
      # The class provides two class methods:  +convert+ and +deconvert+  In
      # the event that you need to transform LaTeX-style markep into entities of
      # some sort, use the former class.  In the event that you need to down-sample
      # macron-characters into LaTeX-style, use the latter.
      # 
      # == Example Code
      # 
      #   # Basic conversion and advanced conversion
      #   puts Text::Latex::Util::Macronconversions.convert("mon\\={e}re", 'mc') #=> monēre
      # 
      #   # Complex de-conversion
      #   puts MacronConversions::MacronDeConverter.new("laudāre") #=> "laud\={a}re"
      # 
      #   # Coup de grace
      #   puts MacronConversions::MacronDeConverter.new(
      #     MacronConversions::MacronConverter.new('to bring up, educate: \={e}duc\={o}, \={e}duc\={a}re, \={e}duc\={a}v\={\i}, \={e}ducatus; education, educator, educable', 'mc').to_s)
      # 
      # == Author     
      # 
      # Steven G. Harms, http://www.stevengharms.com        
      module Macronconversions   
                 
      class << self
          #  Deconverts a string that has macron-bearing vowels from the format to the ASCII representation used by LaTeX.
          #  
          #  The method is recursive and as such the 2 optional arguments are defined after the initial call.
          #  Params:
          #  +word+ :: (a string to convert
          #  +from_format+ Never Directly Called:  Which format of macron should be expected?  See Macronconversions documentation
          #  +conversion_chart+ Never Directly Called:  Which lookup table should the characters of word be tested against?
          def deconvert(word, *arg)
            return "" if word.empty?

            # If the target has already been set, then we should respect that
            # fact.  This makes recurses over longer strings faster
            #
            # If it has not already been set, we derive the type heuristically
            mode =  ((! arg[0].nil?) or 
                     (! arg[0]==:skip)) ?
                  arg[0] 
                :
                  if word =~ /\&\#/
                    :html
                  elsif word =~ /[āēīōūĀĒĪŌŪ]/
                    :mc 
                  elsif word =~ /\\x/
                    :utf8
                  end
            
            # If the mode has not been set, we should have a plain old letter
            # otherwise you want to die since we won't be able to build a
            # chart for a non-existant format.
            raise ArgumentError if (mode.nil? and word.slice(0) !~ /^[a-z]/)
            
            # Mutate the chart, but use the one given, if it was given (i.e.
            # we are in a recursive call)
            mutated_chart = {}
            if arg[1].nil?
              Text::Latex::Util::Macronconversions::CONVERSION_TABLE.each do |k,v|
                mutated_chart[v[mode]]=k
              end
            else
              mutated_chart = arg[1]
            end
            
            # String to which the recurse's outputs will be appended
            #
            # All LaTeX Macron codes begin with an '=' token.  Scan for that
            # using a RegEx.  The value is set to firstSlash.
            # 
            # This is just ugly, but is nothing to be afraid of.
            #
            # You look to see if the character is an ampersand.  That means
            # you've got HTML entities.  Take the ending token of the entity
            # and hold it, and then recursively send the tail to this method
            # to be processed again.  A cheap serialization is established by
            # sending the logic-requiring results on to recursive invocations
            # 
            # The same logic applies to the second if state, we're dealing
            # with the representation of utf-8 characters
            #
            # The third case varies slightly, we have a multibyte *single*
            # character.  This character can be slice!d off and the tail
            # recursively sent onward.
            #
            # Lastly, if you have a plain character, follow the same model as
            # the preceeding.

            return_string = 
              if word.slice(0) == "&"
                word =~ /(&.*?;)(.*)/
                _deconvert_char($1, mutated_chart) + 
                      deconvert(word[($1.length)..-1], mode.to_sym, mutated_chart)                
              elsif word.slice(0) == "\\"
                word =~ /(^\\x..\\x..)(.*)/
                _deconvert_char($1, mutated_chart) + 
                      deconvert(word[($1.length)..-1], mode.to_sym, mutated_chart)
              elsif word.slice(0) =~ /[āēīōūĀĒĪŌŪ]/
                _deconvert_char(word.slice!(0),  mutated_chart) + 
                      deconvert(word, mode.to_sym, mutated_chart)
              else
                # This is kinda ugly.  Particularly arg1.  
                word.slice!(0) + deconvert(word, :skip, mutated_chart)
              end

            # Allow a block to be given to mutate the string after having been fabricated              
            if block_given?
              return_string = (yield return_string )
            end

            # debugger if word == "" 
            return_string
          end

          # Macronconversions::convert is the routine that scans a token for LaTeX macron
          # codes, recursively. Upon the indetification of a macron-ized character, it
          # passes that character to the "private" method MacronConverter#_convert_char
          # 
          # Params:
          # +word+ :: A string that uses the LaTeX standard for macron denotation
          # +mode+ :: How the resultant string should be formatted (mc|utf8|html)
          # 
          # The resultant string may be operated upon by passing an optional block.
          def convert(word, mode=:mc, &b)
            # Ends the recurse
            return "" if word.empty?
            
            # String to which the recurse's outputs will be appended
            #
            # All LaTeX Macron codes begin with an '\\={' token and end with
            # '}' Scan for that using a RegEx thus creating a match and rest. 
            # The match is passed to _convert_char and the rest is recursed to
            # this method.
            return_string = 
              if word.slice(0) == "\\"
                word =~ /(\\.*?})(.*)/
                 _convert_char($1,mode.to_sym) + 
                       convert(word[($1.length)..-1], mode.to_sym)
              else
                 word.slice(0) + convert(word[1..-1],mode)
              end

            # Allow a block to be given to mutate the string after having been fabricated              
            if block_given?
              return_string = (yield return_string )
            end

            return_string
          end
          
          #####################################
          # "Private" method
          # (still available for unit testing, but you probably shouldn't mess with it)
          # 
          # Does the lookup to convert macron bearing character to LaTeX ASCII formatting 
          #####################################
          def _deconvert_char(c, chart)
            begin
              r = chart[c] 
              raise if r.nil?
            rescue
              puts "_deconvert_char failed to find a match for [#{c}]"
              pp chart
              raise 
            end
            r
          end

          #####################################
          # "Private" method
          # (still available for unit testing, but you probably shouldn't mess with it)
          # 
          # Does the lookup to convert LaTeX ASCII to macron bearing character formatting
          #####################################          
          def _convert_char(c,mode)             
            begin
              r = Text::Latex::Util::Macronconversions::CONVERSION_TABLE[c][mode]
              raise if r.nil?
            rescue
              puts "_convert_char failed to find a match for [#{c}]"
              raise
            end
            r
          end
        end
      end
    end
  end
end

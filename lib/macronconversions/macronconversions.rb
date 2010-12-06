# coding: utf-8
require 'macronconversions/conversion_structure'

module Text
  module LaTeX
    module Util
      module Macronconversions    
      class << self

=begin rdoc

=end
          def deconvert(word, *arg)
            return "" if word.empty?

            require 'pp'

            # If the target has already been set, then we should respect that
            # fact.  This makes recurses over longer strings faster
            mode =  (! arg[0].nil?) ? 
                arg[0] :
                if word =~ /\&\#/
                  :html
                elsif word =~ /[āēīōūĀĒĪŌŪ]/
                  :mc 
                elsif word =~ /\\x/
                  :utf8
                end
            
            # If the mode has not been set, we should have a plain old letter
            # otherwise you want to die and write a patch.
            raise ArgumentError if (mode.nil? and word.slice(0) !~ /^[a-z]/)
            
            # Mutate the chart, but use the one given, if it was given (i.e.
            # we are in a recursive call)
            mutated_chart = {}
            if arg[1].nil?
              Text::LatTeX::Util::Macronconversions::CONVERSION_TABLE.each do |k,v|
                mutated_chart[v[mode]]=k
              end
            else
              mutated_chart = arg[1]
            end
            
            # String to which the recurse's outputs will be appended
            #
            # All LaTeX Macron codes begin with an '=' token.  Scan for that using a 
            # RegEx.  The value is set to firstSlash.
            
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
                word.slice!(0) + deconvert(word, :mc, mutated_chart)
              end

            # Allow a block to be given to mutate the string after having been fabricated              
            if block_given?
              return_string = (yield return_string )
            end

            # debugger if word == "" 
            return_string
          end

=begin rdoc

Macronconversions::convert is the routine that scans a token for LaTeX macron
codes, recursively. Upon the indetification of a macron-ized character, it
passes that character to the "private" method MacronConverter#_convert_char

=end                
          def convert(word, mode=:mc, &b)
            # Ends the recurse
            return "" if word.empty?
            
            # String to which the recurse's outputs will be appended
            #
            # All LaTeX Macron codes begin with an '=' token.  Scan for that using a 
            # RegEx.  The value is set to firstSlash.
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
          # Sorta "private" methods
          # (still available for unit testing, but you probably shouldn't mess with them)
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
          
          def _convert_char(c,mode)             
            begin
              r = Text::LatTeX::Util::Macronconversions::CONVERSION_TABLE[c][mode]
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

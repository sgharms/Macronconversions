require 'macronconversions/conversion_structure'

module Text
  module LaTeX
    module Util
      module Macronconversions    
      class << self

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
                return_string = _convert_char($1,mode.to_sym) + 
                                  convert(word[($1.length)..-1], mode.to_sym)
              else
                return_string = word.slice(0) + convert(word[1..-1],mode)
              end

            # Allow a block to be given to mutate the string after having been fabricated              
            if block_given?
              return_string = (yield return_string )
            end

            return_string
          end
          
          #####################################
          # Sorta private methods
          # (still available for unit testing, but you probably shouldn't mess with them)
          #####################################
          
          def _convert_char(c,mode)             
              r = Text::LatTeX::Util::Macronconversions::CONVERSION_TABLE[c][mode]
              (raise RuntimeError if r.nil?) || r
          end
        end
      end
    end
  end
end

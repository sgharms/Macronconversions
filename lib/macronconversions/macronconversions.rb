require 'macronconversions/conversion_structure'

module Text
  module LaTeX
    module Util
      module Macronconversions    
      class << self
          def convert(word, mode=:mc, *args, &b)
            # Ends the recurse
            return "" if word.empty?
            
            # String to which the recurse's outputs will be appended
            return_string = 
              # debugger 
              if word.slice(0) == "\\"
                word =~ /(\\.*?})(.*)/
                return_string = _convert_char($1,mode.to_sym) + 
                                  convert(word[($1.length)..-1], mode.to_sym)
              else
                return_string = word.slice(0) + convert(word[1..-1],mode)
              end

            # Allow a block to be given to mutate the string after having been fabricated
            if block_given?
              yield return_string
            else
              return return_string
            end
          end
          def _convert_char(c,mode)             
              r = Text::LatTeX::Util::Macronconversions::CONVERSION_TABLE[c][mode]
              (raise RuntimeError if r.nil?) || r
          end
        end
      end
    end
  end
end

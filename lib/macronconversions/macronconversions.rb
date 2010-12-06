require 'macronconversions/conversion_structure'

module Text
  module LaTeX
    module Util
      module Macronconversions    
      class << self
          def convert(word, mode=:mc, *args, &b)
            return "" if word.empty?
            
            return_string = ""
            if word.slice(0) == "\\"
              # debugger
              word =~ /(\\.*})(.*)/
              return_string = _convert_char($1,mode.to_sym) + convert(word[($1.length)..-1], mode.to_sym)
            else
              return_string = word.slice(0) + convert(word[1..-1],mode)
            end
            
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

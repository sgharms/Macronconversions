# coding: utf-8
module Text
  module Latex
    module Util
      module Macronconversions
        CONVERSION_TABLE = {
          "\\={a}"   => 
                        {
                          :mc   => "ā",
                          :utf8 => "\\xc4\\x81",
                          :html => "&#x101;"
                        },
          "\\={e}"   => 
                        {
                          :mc   => "ē",
                          :utf8 => "\\xc4\\x93",
                          :html => "&#x113;"
                        },
          "\\={\\i}" => 
                        {
                          :mc   => "ī",
                          :utf8 => "\\xc4\\xab",
                          :html => "&#x12b;"
                        },
          "\\={o}"   => 
                        {
                          :mc   => "ō",
                          :utf8 => "\\xc5\\x8d",
                          :html => "&#x14d;"
                        },
          "\\={u}"   => 
                        {
                          :mc   => "ū",
                          :utf8 => "\\xc5\\xab",
                          :html => "&#x16b;"
                        },
          "\\={A}"   => 
                        {
                          :mc   => "Ā",
                          :utf8 => "\\xc4\\x80",
                          :html => "&#x100;"
                        },
          "\\={E}"   => 
                        {
                          :mc   => "Ē",
                          :utf8 => "\\xc4\\x92",
                          :html => "&#x112;"
                        },
          "\\={\\I}" => 
                        {
                          :mc   => "Ī",
                          :utf8 => "\\xc4\\xaa",
                          :html => "&#x12a;"
                        },
          "\\={O}"   => 
                        {
                          :mc   => "Ō",
                          :utf8 => "\\xc5\\x8c",
                          :html => "&#x14c;"
                        },
          "\\={U}"   => 
                        {
                          :mc   => "Ū",
                          :utf8 => "\\xc5\\xaa",
                          :html => "&#x16a;"
                        }
        }                               
      end
    end
  end
end
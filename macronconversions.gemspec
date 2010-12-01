# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "macronconversions/version"

Gem::Specification.new do |s|
  s.name        = "macronconversions"
  s.version     = Macronconversions::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Steven G. Harms"]
  s.email       = ["macron_conversions@sgharms.oib.com"]
  s.homepage    = "http://rubygems.org/gems/macronconversions"
  s.summary     = %q{Convert strings with LaTeX-style macron notation to
  strings with embedded high-byte characters or UTF-8 escape codes.}
  s.description = %q{Convert strings like 'laud\={a}re' to 'laudāre' using
  ASCII-compatible escape codes.}

  s.rubyforge_project = "macronconversions"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end

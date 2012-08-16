# -*- encoding: utf-8 -*-
require File.expand_path('../lib/csv_to_object/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Ian Whitney"]
  gem.email         = ["ian@ianwhitney.com"]
  gem.description   = %q{Takes a CSV file and returns a a collection of objects generated by that CSV file.}
  gem.summary       = %q{Takes a CSV file and returns a a collection of objects generated by that CSV file.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "csv_to_object"
  gem.require_paths = ["lib"]
  gem.version       = CsvToObject::VERSION
  
  gem.add_development_dependency "rspec"
end

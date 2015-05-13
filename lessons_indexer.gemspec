require File.expand_path("../lib/lessons_indexer/version", __FILE__)

Gem::Specification.new do |spec|
  spec.name          = "LessonsIndexer"
  spec.version       = LessonsIndexer::VERSION
  spec.authors       = ["Ilya Bodrov"]
  spec.email         = ["golosizpru@gmail.com"]
  spec.homepage      = "https://github.com/bodrovis/lessons_indexer"
  spec.summary       = %q{Lessons Indexer for Learnable}
  spec.description   = %q{Lessons Indexer for Learnable}
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "slop", "~> 4.1"
  spec.add_dependency "facets", "~> 3.0.0"
  spec.add_dependency "colorize", "~> 0.7.7"

  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
end
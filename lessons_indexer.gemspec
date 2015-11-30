require File.expand_path("../lib/lessons_indexer/version", __FILE__)

Gem::Specification.new do |spec|
  spec.name          = "lessons_indexer"
  spec.version       = LessonsIndexer::VERSION
  spec.authors       = ["Ilya Bodrov"]
  spec.email         = ["golosizpru@gmail.com"]
  spec.homepage      = "https://github.com/bodrovis/lessons_indexer"
  spec.summary       = %q{Lessons Indexer for Learnable}
  spec.description   = %q{Lessons Indexer for Learnable}
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = ["lessons_indexer"]
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "slop", "~> 4.2"
  spec.add_dependency "facets", "~> 3.0"
  spec.add_dependency "colorize", "~> 0.7.7"

  spec.add_development_dependency "rake", "~> 10.4"
  spec.add_development_dependency "rspec", "~> 3.2"
  spec.add_development_dependency "codeclimate-test-reporter", "~> 0.4"
  spec.add_development_dependency "fasterer", "~> 0.1"
end
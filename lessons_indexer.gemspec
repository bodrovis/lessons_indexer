require File.expand_path("../lib/lessons_indexer/version", __FILE__)

Gem::Specification.new do |spec|
  spec.name          = "lessons_indexer"
  spec.version       = LessonsIndexer::VERSION
  spec.authors       = ["Ilya Bodrov"]
  spec.email         = ["golosizpru@gmail.com"]
  spec.homepage      = "https://github.com/bodrovis/lessons_indexer"
  spec.summary       = %q{Lessons Indexer for Learnable}
  spec.description   = %q{Lessons Indexer for Learnable. Build index, adds headings, generates PDFs from Markdown and pushes to GitHub.}
  spec.license       = "MIT"

  spec.required_ruby_version = '>= 2.0.0'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = ["lessons_indexer"]
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "slop", "~> 4.2"
  spec.add_dependency "facets", "~> 3.0"
  spec.add_dependency "colorize", "~> 0.7.7"
  spec.add_dependency "messages_dictionary", "~> 0.1.2"

  spec.add_development_dependency "rake", "~> 11.1"
  spec.add_development_dependency "rspec", "~> 3.4"
  spec.add_development_dependency "codeclimate-test-reporter", "~> 0.4"
  spec.add_development_dependency "fasterer", "~> 0.3"
end
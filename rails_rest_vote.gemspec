# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rails_rest_vote/version'

Gem::Specification.new do |spec|
  spec.name          = "rails_rest_vote"
  spec.version       = RailsRestVote::VERSION
  spec.authors       = ["satendra02"]
  spec.email         = ["satendrarai5@gmail.com"]

  spec.summary       = %q{Add voting ability to rails models.}
  spec.description   = %q{Provide data on elements in the periodic table.}
  spec.homepage      = "https://github.com/tixdo/rails_rest_vote"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rails", "~> 4.2.5"
  spec.add_dependency "jbuilder", "~> 2.0"
  spec.add_dependency "orm_adapter", "~> 0.1"
end

# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hiragana_codes/version'

Gem::Specification.new do |spec|
  spec.name          = "hiragana_codes"
  spec.version       = HiraganaCodes::VERSION
  spec.authors       = ["sei0o"]
  spec.email         = ["sei0o@live.jp", "sei0o@sei0o.xyz"]

  spec.summary       = "plus+codes in Japanese Hiragana"
  # spec.description   = %q{TODO: Write a longer description or delete this line.}
  spec.homepage      = "https://github.com/sei0o/hiraganaCodes"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
end

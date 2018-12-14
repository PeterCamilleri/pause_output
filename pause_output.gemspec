
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "pause_output/version"

Gem::Specification.new do |spec|
  spec.name          = "pause_output"
  spec.version       = PauseOutput::VERSION
  spec.authors       = ["PeterCamilleri"]
  spec.email         = ["peter.c.camilleri@gmail.com"]

  spec.summary       = %q{TODO: Write a short summary, because RubyGems requires one.}
  spec.description   = %q{TODO: Write a longer description or delete this line.}
  spec.homepage      = "https://github.com/PeterCamilleri/pause_output"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
                          f.match(%r{^(test|docs)/})
                        end
  spec.bindir        = "exe"
  spec.executables   = spec
                         .files
                         .reject { |f| f.downcase == 'exe/readme.md'}
                         .grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency 'minitest_visible', "~> 0.1"
  spec.add_development_dependency 'reek', "~> 5.0.2"
end

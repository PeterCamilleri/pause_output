lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "pause_output/version"

Gem::Specification.new do |spec|
  spec.name          = "pause_output"
  spec.version       = PauseOutput::VERSION
  spec.authors       = ["PeterCamilleri"]
  spec.email         = ["peter.c.camilleri@gmail.com"]

  spec.summary       = %q{Pause lengthy console output.}
  spec.description   = %q{pause_output: A simple facility to pause output on the console terminal.}
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

  spec.add_runtime_dependency     'mini_term', "~> 0.1.0"
end

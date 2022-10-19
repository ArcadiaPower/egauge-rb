lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "egauge/version"

Gem::Specification.new do |spec|
  spec.name          = "egauge-rb"
  spec.version       = Egauge::VERSION
  spec.authors       = ["Joey Ferguson"]
  spec.email         = ["fergmastaflex@gmail.com"]

  spec.summary       = %q{Ruby client for egauge inverter}
  spec.description   = %q{Ruby client for egauge inverter}
  spec.homepage      = "https://github.com/ArcadiaPower/egauge-rb"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "httpclient"
  spec.add_dependency "nokogiri", "1.13.9"
  spec.add_dependency "activesupport", "5.2.1"

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry"
end

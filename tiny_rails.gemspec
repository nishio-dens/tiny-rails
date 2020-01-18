version = File.read(File.expand_path("TINY_RAILS_VERSION", __dir__)).strip

Gem::Specification.new do |spec|
  spec.name          = "tiny_rails"
  spec.version       = version
  spec.authors       = ["Shinsuke Nishio"]
  spec.email         = ["nishio@densan-labs.net"]

  spec.summary       = %q{Full Scratch Ruby on Rails}
  spec.description   = %q{Full scratch Ruby on Rails}
  spec.homepage      = "https://densan-labs.net"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  # spec.metadata["source_code_uri"] = ""
  # spec.metadata["changelog_uri"] = ""

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "tiny_railties", version
  spec.add_dependency "tiny_actionpack", version
end

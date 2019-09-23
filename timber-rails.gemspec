lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "timber-rails/version"

Gem::Specification.new do |spec|
  spec.name          = "timber-rails"
  spec.version       = Timber::Integrations::Rails::VERSION
  spec.authors       = ["Timber Technologies, Inc."]
  spec.email         = ["hi@timber.io"]

  spec.summary       = %q{Timber.io Rails integration}
  spec.homepage      = "https://docs.timber.io/languages/ruby/"
  spec.license       = "ISC"

  spec.required_ruby_version = '>= 1.9.0'

  if spec.respond_to?(:metadata)
    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = "https://github.com/timberio/timber-ruby-rails"
    spec.metadata["changelog_uri"] = "https://github.com/timberio/timber-ruby-rails/blob/master/README.md"

  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "rails", ">= 3.0.0"
  spec.add_runtime_dependency "timber", "~> 3.0"
  spec.add_runtime_dependency "timber-rack", "~> 1.0"

  spec.add_development_dependency "bundler", ">= 0.0"

  spec.add_development_dependency "rake", ">= 0.8"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_development_dependency("bundler-audit", ">= 0")
  spec.add_development_dependency("rails_stdout_logging", ">= 0")
  spec.add_development_dependency("rspec-its", ">= 0")
  spec.add_development_dependency("timecop", ">= 0")

  rails_version = 0
  if ENV.key?('RAILS_VERSION')
    rails_version = ENV['RAILS_VERSION'].to_f
  elsif ENV.key?('BUNDLE_GEMFILE')
    matches = File.basename(ENV['BUNDLE_GEMFILE'], '.gemfile').match(/-([0-9.]+)\z/)
    rails_version = matches[1].to_f if matches
  end

  if RUBY_PLATFORM == "java"
    spec.add_development_dependency('activerecord-jdbcsqlite3-adapter', '>= 0')
  else
    if rails_version >= 6
      spec.add_development_dependency('sqlite3', '~> 1.4.0')
    else
      spec.add_development_dependency('sqlite3', '1.3.13')
    end
  end

  if RUBY_VERSION
    ruby_version = Gem::Version.new(RUBY_VERSION)

    if ruby_version < Gem::Version.new("2.0.0")
      spec.add_development_dependency('public_suffix', '~> 1.4.6')
      spec.add_development_dependency('term-ansicolor', '~> 1.3.2')
      spec.add_development_dependency('tins', '~> 1.5.0')
      spec.add_development_dependency('webmock', '~> 2.2.0')
    else
      spec.add_development_dependency('webmock', '~> 2.3')
    end
  else
    spec.add_development_dependency('webmock', '~> 2.3')
  end
end

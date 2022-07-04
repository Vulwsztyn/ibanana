# frozen_string_literal: true

require_relative 'lib/ibanana/version'

Gem::Specification.new do |spec|
  spec.name = 'ibanana'
  spec.version = Ibanana::VERSION
  spec.authors = ['Artur Mostowski']
  spec.email = ['artur.mostowski@protonmail.com']

  spec.summary = 'Gem to validate IBANs and create IBANs from BBANs.'
  spec.description = 'Gem to validate IBANs and create IBANs from BBANs.'
  spec.homepage = 'https://github.com/Vulwsztyn/ibanana'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.6.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/Vulwsztyn/ibanana'
  spec.metadata['changelog_uri'] = 'https://github.com/Vulwsztyn/ibanana/blob/master/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features|autogen)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'dry-monads', '~> 1.3'

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end

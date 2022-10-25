# frozen_string_literal: true

require_relative "lib/easy_sheet_io/version"

Gem::Specification.new do |spec|
  spec.name          = "easy_sheet_io"
  spec.version       = EasySheetIo::VERSION
  spec.authors       = ["show-o-atakun"]
  spec.email         = ["shun_yamaguchi_tc@live.jp"]

  spec.summary       = "A simple way to Open .csv, .xls, .xlsx files."
  spec.description   = "A simple way to Open .csv, .xls, .xlsx files. You can convert it to 2D array, hash, data frame."
  spec.homepage      = "https://github.com/show-o-atakun/easy_sheet_io"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/show-o-atakun/easy_sheet_io"
  ## spec.metadata["changelog_uri"] = "https://github.com/show-o-atakun/easy_sheet_io_gemspec"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"
  ## spec.add_dependency "rake", "~> 13.0"
  ## spec.add_dependency "rspec", "~> 3.0"
  ## spec.add_dependency "rubocop", "~> 0.80"
  
  spec.add_dependency "daru", ">= 0.3"
  spec.add_dependency "rover-df", ">= 0.2.7"
  spec.add_dependency "smarter_csv", ">= 1.4.2"
  spec.add_dependency "roo-xls", ">= 1.2.0"
  spec.add_dependency "spreadsheet", ">= 1.3.0"
  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end

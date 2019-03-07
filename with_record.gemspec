$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "with_record/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "with_record"
  spec.version     = WithRecord::VERSION
  spec.authors     = ["Igor Kasyanchuk"]
  spec.email       = ["igorkasyanchuk@gmail.com"]
  spec.homepage    = "https://github.com/igorkasyanchuk/with_record"
  spec.summary     = "Include more records in your relations/associations, just to DRY your code."
  spec.description = "Include more records in your relations/associations, just to DRY your code."
  spec.license     = "MIT"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails"

  spec.add_development_dependency "sqlite3", "~> 1.3.6"
end

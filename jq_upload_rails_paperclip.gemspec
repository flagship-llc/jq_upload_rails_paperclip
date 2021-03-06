# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jq_upload_rails_paperclip/version'

Gem::Specification.new do |spec|
  spec.name          = "jq_upload_rails_paperclip"
  spec.version       = JqUploadRailsPaperclip::VERSION
  spec.authors       = ["Keitaroh Kobayashi"]
  spec.email         = ["keita@kkob.us"]
  spec.summary       = %q{A quick library to make uploading files in the background less painful.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "jquery.fileupload-rails", "~> 1.10"
  spec.add_dependency "paperclip", "~> 6.0"
  spec.add_dependency 'activesupport', '>= 0'

  spec.add_dependency 'coffee-rails', '>= 4.0'

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec-rails", "~> 3.0"
  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "shoulda-matchers"
  spec.add_development_dependency "database_cleaner"
end

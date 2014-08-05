require "jq_upload_rails_paperclip/version"
require "jq_upload_rails_paperclip/background_uploadable"

module JqUploadRailsPaperclip

  module ClassMethods
    def background_uploadable(name)
      BackgroundUploadable.define_on(self, name)
    end
  end
end

require 'jq_upload_rails_paperclip/engine' if defined?(Rails)

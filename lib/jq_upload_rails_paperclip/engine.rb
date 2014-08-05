require 'active_support/dependencies'
require 'jquery.fileupload-rails'
require 'paperclip'

require 'jq_upload_rails_paperclip/glue'
require 'jq_upload_rails_paperclip/rails/routes'

module JqUploadRailsPaperclip
  class Engine < Rails::Engine

    config.before_eager_load { |app| app.reload_routes! }

    initializer 'jq_upload_rails_paperclip.insert_into_active_record' do |app|
      ActiveSupport.on_load :active_record do
        JqUploadRailsPaperclip::Engine.insert
      end
    end

    def self.insert
      if defined?(ActiveRecord)
        ActiveRecord::Base.send(:include, JqUploadRailsPaperclip::Glue)
      end
    end

  end
end

require 'rails/generators/active_record'

module JqUploadRailsPaperclip
  class InstallGenerator < ActiveRecord::Generators::Base

    desc "Install the Upload tables."

    source_root File.expand_path("../templates", __FILE__)

    def generate_migration
      migration_template "uploads_migration.rb", "db/migrate/#{migration_file_name}"
    end

    def migration_name
      "create_uploads"
    end

    def migration_file_name
      "#{migration_name}.rb"
    end

    def migration_class_name
      migration_name.camelize
    end
  end
end

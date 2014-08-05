module JqUploadRailsPaperclip
  class Upload < ActiveRecord::Base
    belongs_to :user

    has_attached_file :file, styles: { thumbnail: '256x256>' }

    validates_attachment :file,
      presence: true,
      content_type: { content_type: ["image/jpg", "image/jpeg", "image/pjpeg", "image/png", "image/gif"] }

    validates :target_type, :target_attr, presence: true

    def file_url
      file.url(:thumbnail)
    end

    # def applicable_styles
    #   klass = target_type.constantize
    #   fail "Suspect motive. We were expecting a subclass of ActiveRecord::Base, got <#{klass}>" unless klass < ActiveRecord::Base

    #   if klass.respond_to? :attachment_definitions
    #     {
    #       thumbnail: klass.attachment_definitions[target_attr.to_sym][:styles][:thumbnail] || '256x256>'
    #     }
    #   end
    # end
  end
end

module JqUploadRailsPaperclip
  class Upload < ActiveRecord::Base
    belongs_to :user

    has_attached_file :file, styles: { thumbnail: '256x256>' }

    validates_attachment :file,
      presence: true,
      content_type: { content_type: ["image/jpg", "image/jpeg", "image/pjpeg", "image/png", "image/gif"] }

    validates :target_type, :target_attr, presence: true

    validate :instance_validations

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

    private

    def instance_validations
      klass = target_klass
      validators = klass.validators
      att = target_attr.to_sym

      validators.select do |e|
        e.attributes.include?(att) && e.class.to_s.deconstantize == 'Paperclip::Validators'
      end.each do |e|
        options = _merge_attributes([:file, e.options])
        validates_with e.class, options

      end
    end

    def target_klass
      klass = target_type.constantize
      fail "Suspect motive. We were expecting a subclass of ActiveRecord::Base, got <#{klass}>" unless klass < ActiveRecord::Base
      klass
    end
  end
end

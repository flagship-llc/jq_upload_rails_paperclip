module JqUploadRailsPaperclip
  class BackgroundUploadable
    def self.define_on(klass, name)
      new(klass, name).define
    end

    def initialize(klass, name)
      @klass = klass
      @name = name
    end

    def define
      define_attributes
      add_active_record_callbacks
    end

    private

    def define_attributes
      @klass.send :attr_accessor, :"#{@name}_id"
    end

    def add_active_record_callbacks
      name = @name
      # Move the image from the upload
      @klass.send(:before_validation) do
        _image_id = send(:"#{name}_id").to_i
        if _image_id > 0
          upload = user.uploads.find _image_id
          send(:"#{name}=", upload.file)
        end
      end
    end
  end
end

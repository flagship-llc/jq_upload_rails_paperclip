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
      @klass.send :attr_accessor, :"#{@name}_id", :"remove_#{@name}"
    end

    def add_active_record_callbacks
      name = @name

      # Remove the image if the remove_image tag is set.
      @klass.send(:before_validation) do
        _remove_image = send(:"remove_#{name}")
        if _remove_image == '1'
          send(:"#{name}=", nil)
          send(:"#{name}_id=", '')
        end
        send(:"remove_#{name}=", nil)
      end

      # Move the image from the upload
      @klass.send(:before_validation) do
        _image_id = send(:"#{name}_id")
        if !_image_id.blank? and _image_id.strip != '0'
          upload = ::JqUploadRailsPaperclip::Upload.where(identifier: _image_id).first!
          send(:"#{name}=", upload.file)
        end
      end
    end
  end
end

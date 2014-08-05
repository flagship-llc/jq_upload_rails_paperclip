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
          self.image = nil
          send(:"#{name}=", nil)
          send(:"#{name}_id=", 0)
        end
        send(:"remove_#{name}=", nil)
      end

      # Move the image from the upload
      @klass.send(:before_validation) do
        _image_id = send(:"#{name}_id").to_i
        if _image_id > 0
          upload_base_model = if self.kind_of? User
                                self
                              else
                                user
                              end

          upload = upload_base_model.uploads.find _image_id
          send(:"#{name}=", upload.file)
        end
      end
    end
  end
end

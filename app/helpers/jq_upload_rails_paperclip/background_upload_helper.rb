module JqUploadRailsPaperclip
  module BackgroundUploadHelper
    def background_file_field_tag(f, attrib, options={})
      fail ArgumentError, 'Please pass in the contents as a block.' unless block_given?

      model = f.object
      options[:class] = options[:class].split(' ') if options[:class].kind_of?(String)
      options[:class] << 'fileinput-button'

      content_tag(:div, class: %w( fileupload-wrapper )) do
        buf = ''

        buf << content_tag(:div, class: %w( image-placeholder )) do
          if model.send(:"#{attrib}?")
            if !model.class.attachment_definitions[attrib.to_sym].nil?
              if model.persisted?
                has_thumbnail = model.class.attachment_definitions[attrib.to_sym][:styles].has_key? :thumbnail
                image_tag(model.send(attrib).url(has_thumbnail ? :thumbnail : :original))
              else
                upload = model.user.uploads.find(model.image_id)
                image_tag(upload.file.url(:thumbnail))
              end
            end
          end
        end

        classes = %w( remove-image-controls )
        classes << 'hidden' unless model.send(:"#{attrib}?")
        buf << content_tag(:div, class: classes) do
          _buf = f.check_box(:"remove_#{attrib}")
          _buf << f.label(:"remove_#{attrib}")
          _buf.html_safe
        end

        buf << content_tag(:div, class: %w( progress hidden )) do
          content_tag(:div,
            class: %w( progress-bar ),
            role: 'progressbar',
            'aria-valuenow' => '0',
            'aria-valuemin' => '0',
            'aria-valuemax' => '100',
            style: 'width: 0%;') do
            "0%"
          end
        end

        buf << content_tag(:div, options) do
          _buf = yield

          _buf << file_field_tag('files[]',
            class: %w( form-control background-fileupload ),
            data: {
              type: model.class.to_s,
              attr: attrib
            },
            id: "files_uploader_#{Time.now.to_i}")

          _buf.html_safe
        end

        image_id_value = (model.send(:"#{attrib}?") && model.persisted?) ? 0 : (model.send(:"#{attrib}_id") || 0)
        buf << f.hidden_field(:"#{attrib}_id", value: image_id_value, class: %w( upload-id-holder ))

        buf.html_safe
      end

    end
  end
end

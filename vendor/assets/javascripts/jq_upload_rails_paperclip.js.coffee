#= require jquery.fileupload

$ () ->

  install_uploaders = () ->
    $('.background-fileupload').each () ->
      $uploader = $ this
      uploader_installed = $uploader.data('uploader-installed') == 'yes'
      if uploader_installed
        return

      $uploader.data 'uploader-installed', 'yes'
      $wrapper = $uploader.parents '.fileupload-wrapper'
      $image_placeholder = $wrapper.find '.image-placeholder'
      $remove_image_controls = $wrapper.find '.remove-image-controls'
      $upload_id_holder = $wrapper.find '.upload-id-holder'

      $uploader.fileupload
        url: Routes.uploads_path()
        dataType: 'json'
        type: 'POST'
        limitMultiFileUploads: 1
        autoUpload: true
        multipart: true
        formData:
          'survey[target_type]': $uploader.data 'type'
          'survey[target_attr]': $uploader.data 'attr'
      .bind 'fileuploaddone', (e, data) ->
        result = data.result

        if $image_placeholder.find('img').length >= 1
          $image_placeholder.find('img').attr 'src', result.file_url
        else
          imgElement = document.createElement 'img'
          imgElement.src = result.file_url
          $image_placeholder.append imgElement

        $remove_image_controls.removeClass 'hidden'

        $upload_id_holder.val result.id

  install_uploaders()

  $(document).on 'nested:fieldAdded', () ->
    install_uploaders()

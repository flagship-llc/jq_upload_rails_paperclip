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

      $progress_wrapper = $wrapper.find '.progress'
      $progress_bar = $progress_wrapper.find '.progress-bar'

      setProgress = (percent) ->
        $progress_bar.attr
          'aria-valuenow': percent
        .css
          width: "#{percent}%"
        .text "#{percent}%"

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
      .bind 'fileuploadfail', (e, data) ->
        joined_errors = new Array
        for e in data.jqXHR.responseJSON.errors
          joined_errors.push e

        text = "ファイルアップロードが失敗しました。下記のエラーをご確認ください。\n\n#{joined_errors.join "\n"}"
        alert text

      .bind 'fileuploadstart', (e, data) ->

        setProgress 0
        $progress_wrapper.removeClass 'hidden'

      .bind 'fileuploadstop', (e, data) ->

        window.setTimeout () ->
          $progress_wrapper.addClass 'hidden'
        , 800

      .bind 'fileuploadprogress', (e, data) ->
        progress = parseInt(data.loaded / data.total * 100, 10)
        setProgress progress


  install_uploaders()

  $(document).on 'nested:fieldAdded', () ->
    install_uploaders()

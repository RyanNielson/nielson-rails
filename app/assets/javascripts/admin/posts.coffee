# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('pre').each  (i, block) ->
     hljs.highlightBlock block



  uploadAttachment = (attachment) ->
    file = attachment.file

    fileInput = $('#post_image')
    form = $(fileInput.parents('form:first'))
    submitButton = form.find('input[type="submit"]')
    progressBar  = $("<div class='bar'></div>")
    barContainer = $("<div class='progress'></div>").append(progressBar)
    fileInput.after(barContainer);
    fileInput.fileupload
      # fileInput: fileInput,
      files: attachment.file
      url: form.data('url')
      type: 'POST'
      autoUpload: true
      formData: form.data('form-data')
      paramName: 'file'
      dataType: 'XML'
      replaceFileInput: false
      send: (e, data) ->
        console.log "send"
      progressall: (e, data) ->
        progress = parseInt(data.loaded / data.total * 100, 10)
        console.log progress + '%'
        progressBar.css('width', progress + '%')
      start: (e) ->
        console.log 'start'
        submitButton.prop('disabled', true);

        progressBar.
          css('background', 'green').
          css('display', 'block').
          css('width', '0%').
          text("Loading...")
      done: (e, data) ->
        console.log('DONE')
        submitButton.prop('disabled', false)
        progressBar.text("Uploading done")

        # extract key and generate URL from response
        key = $(data.jqXHR.responseXML).find("Key").text()
        url = '//' + form.data('host') + '/' + key

        # create hidden field
        input = $("<input />", { type:'hidden', name: fileInput.attr('name'), value: url })
        form.append(input);
      fail: (e, data) ->
        submitButton.prop('disabled', false);

        progressBar.
          css("background", "red").
          text("Failed");

  document.addEventListener 'trix-attachment-add', (event) ->
    attachment = event.attachment
    uploadAttachment attachment
#

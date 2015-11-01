# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  hljs.initHighlightingOnLoad();

  $('#post_preview').on 'click', (event) ->
    console.log "jhkh"
    $.ajax(
      data:
        markdown: $('#post_body_markdown').val()
      url: $(@).data('url')
      method: 'POST'
      dataType: 'script'
    )
#   $('#search_geocode').live('click', function(event){
#     event.preventDefault();
#     $.post($(this).attr('data-href') + "?address=" + $($(this).attr('data-address-id')).val(), function(data){} );
# });
  # $('pre').each  (i, block) ->
  #    hljs.highlightBlock block



  # uploadAttachment = (attachment) ->
  #   file = attachment.file
  #
  #   fileInput = $('#post_image')
  #   form = $(fileInput.parents('form:first'))
  #   submitButton = form.find('input[type="submit"]')
  #   progressBar  = $("<div class='bar'></div>")
  #   barContainer = $("<div class='progress'></div>").append(progressBar)
  #   fileInput.after(barContainer);
  #   fileInput.fileupload
  #     # fileInput: fileInput,
  #     files: attachment.file
  #     url: form.data('url')
  #     type: 'POST'
  #     autoUpload: true
  #     formData: form.data('form-data')
  #     paramName: 'file'
  #     dataType: 'XML'
  #     replaceFileInput: false
  #     progressall: (e, data) ->
  #       attachment.setUploadProgress(parseInt(data.loaded / data.total * 100, 10))
  #       console.log attachment.getUploadProgress()
  #     start: (e) ->
  #       console.log 'start'
  #       submitButton.prop('disabled', true)
  #     done: (e, data) ->
  #       console.log('DONE')
  #       key = $(data.jqXHR.responseXML).find("Key").text()
  #       url = '//' + form.data('host') + '/' + key
  #
  #       console.log url
  #       attachment.setAttributes({
  #         url: url,
  #         href: url,
  #         width: '100%',
  #         height: '100%'
  #       });
  #     fail: (e, data) ->
  #       console.log 'fail'
  #
  # document.addEventListener 'trix-attachment-add', (event) ->
  #   attachment = event.attachment
  #   uploadAttachment attachment
#

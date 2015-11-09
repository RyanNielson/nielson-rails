# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  dropzone = $("#post_body_markdown").dropzone
    url: $('#post_body_markdown').data('imageUploader').url
    clickable: false
    previewsContainer: ''
    accept: (file, done) ->
      $.get '/admin/posts/s3_policy', (response) ->
        file.postData = response.fields;
        done()
    init: ->
      @.on "success", (file, response) ->
        url = $(response).find('location').text()
        key = $(response).find('key').text()
        text_area_content = $('#post_body_markdown').val()
        image_tag = "![#{key}](#{url})"

        selectionStart = $('#post_body_markdown').prop("selectionStart")

        output = text_area_content.substr(0, selectionStart) + "\n#{image_tag}" + text_area_content.substr(selectionStart);

        $('#post_body_markdown').val(output).change()
      @.on "sending", (file, xhr, formData) ->
        $.each file.postData, (k, v) ->
          formData.append(k, v)

  $('#post_preview').on 'click', (event) ->
    $.ajax(
      url: $(@).data("url")
      data:
        markdown: $('#post_body_markdown').val()
      method: 'POST'
      dataType: 'script'
    )

  $("#post_body_markdown").on 'keydown', (event) ->
    keyCode = event.which

    if keyCode == 9 && document.queryCommandSupported('insertText')
      document.execCommand('insertText', false, "  ")
      event.preventDefault()

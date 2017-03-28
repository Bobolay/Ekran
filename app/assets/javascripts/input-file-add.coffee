attach_button = $('.attach-file-field')
file_field = $('.added-file-field')
remove_file = $('.remove-file')

$('input[type=file]').on('change', (e)->
    file = $(this)
    file_field.html(file.val())
    if file.length
      attach_button.addClass('hidden')
      remove_file.addClass('visible')
    else
      remove_file.removeClass('visible')
)

remove_file.on('click', ->
  file_field.empty()
  $(this).removeClass('visible')
  attach_button.removeClass('hidden')
)
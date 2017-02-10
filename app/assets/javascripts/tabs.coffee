$document.on 'click', '.tab-button', ->

  #     T A B     B U T T O N S
  tab_button = $(this)
  tab_buttons_wrapper = tab_button.closest('.tab-buttons')

  tab_button_index = tab_button.index()

  #     T A B     C O N T E N T
  tab_content_wrapper = tab_buttons_wrapper.parent().parent().find('.tab-content-wrapper')
  tab_content = tab_content_wrapper.children()

  #     P E R F O R M     A C T I O N S

  tab_buttons_wrapper.children().removeClass('active')
  tab_button.addClass('active')

  tab_content.filter('.active').removeClass('active')
  next = tab_content.eq(tab_button_index)
  next.addClass('active')
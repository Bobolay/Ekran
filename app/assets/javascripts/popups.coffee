$document.ready ->

#     d e c l a r e     g e n e r a l s     v a r i a b l e s

  popup = $('.popup-container')
  popup_button = $('.request-button')
  close_popup = $('.close-popup')

#     s p e c i f i c     v a r i a b l e s

  design_request_button = $('.design-request-button')
  design_request_popup = $('.design-request-popup')

  call_me_back_popup = $('.call-me-back-popup')
  call_me_button = $('.call-me-back-button')
  
  chat_popup = $('.chat-popup')
  chat_button = $('.chat-online-button')

  success_popup = $('.success-popup')


  design_request_button.on 'click', ->
    popup.removeClass('visible')
    $('.mask').addClass('visible ')
    design_request_popup.addClass('visible')

  call_me_button.on 'click', ->
    popup.removeClass('visible')
    $('.mask').addClass('visible ')
    call_me_back_popup.addClass('visible')

  chat_button.on 'click', ->
    popup.removeClass('visible')
    $('.mask').addClass('visible ')
    chat_popup.addClass('visible')


#     c l i c k     o u t s i d e

  $.clickOut('.popup-container',
    ()->
      $('.popup-container').removeClass('visible')
      $('.mask').removeClass('visible')
    {except: '.popup-container, .request-button'}
  )

  #     c l o s e     p o p u p

  close_popup.on 'click', ->
    popup.removeClass('visible')
    $('.mask').removeClass('visible')

  show_alert_success = ()->
    popup.removeClass('visible')
    success_popup.addClass('visible')



  $("input[type=tel]").each ()->
    $(".input-tel:not(.mask-initialized)").each(
      ()->
        $input_wrap = $(this)
        $input_wrap.addClass("mask-initialized")
        $input_wrap.find("input").mask("+99 (999) 999 99 99")
    )

  $("form.validate").each ->


    $(this).validate

      submitHandler: (form, e)->
        e.preventDefault()
        console.log "args: ", arguments
        url = $(form).attr("action")
        data = $(form).serializeArray()
        method = $(form).attr("method")
        $(form).ajaxSubmit()
        return show_alert_success()

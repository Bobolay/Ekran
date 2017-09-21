track_popup_open = (key)->
  return if !key || !key.length
  console.log "track_popup_open: ", key
  logEvent("popup", "open", key)
  page_url = window.location.pathname
  if !page_url.endsWith("/")
    page_url += "/"
  page_url += "open-#{key}-popup"
  logPageView(page_url)

track_popup_form_submit = (key)->
  return if !key || !key.length
  console.log "track_popup_form_submit: ", key
  logEvent("popup", "submit_form", key)
  page_url = window.location.pathname
  if !page_url.endsWith("/")
    page_url += "/"
  page_url += "popup-#{key}-submit-form"
  logPageView(page_url)

$document.on "ready", ->

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

  dealer_popup = $('.dealer-popup')
  dealer_button = $('.dealer-popup-button')

  success_popup = $('.success-popup')


  design_request_button.on 'click', ->
    popup.removeClass('visible')
    $('.mask').addClass('visible ')
    design_request_popup.addClass('visible')
    popup_key = design_request_popup.attr("data-popup-key")
    track_popup_open(popup_key)

  call_me_button.on 'click', ->
    popup.removeClass('visible')
    $('.mask').addClass('visible ')
    call_me_back_popup.addClass('visible')
    popup_key = call_me_back_popup.attr("data-popup-key")
    track_popup_open(popup_key)

  chat_button.on 'click', ->
    popup.removeClass('visible')
    $('.mask').addClass('visible ')
    chat_popup.addClass('visible')
    popup_key = chat_popup.attr("data-popup-key")
    track_popup_open(popup_key)

  dealer_button.on 'click', ->
    popup.removeClass('visible')
    $('.mask').addClass('visible ')
    dealer_popup.addClass('visible')
    popup_key = dealer_popup.attr("data-popup-key")
    track_popup_open(popup_key)


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






  $(".input-tel:not(.mask-initialized) input").mask("+00 (000) 000 00 00")
  $(".input-tel:not(.mask-initialized)").addClass("mask-initialized")




  $("form.validate").each ->


    $(this).validate

      submitHandler: (form, e)->
        e.preventDefault()
        $form = $(form)
        console.log "args: ", arguments
        url = $form.attr("data-action") || $form.attr("action")
        data = $form.serializeArray()
        method = $form.attr("method")
        $form.ajaxSubmit({url: url})
        $form[0].reset()
        popup_key = $form.closest(".popup-container").attr("data-popup-key")
        track_popup_form_submit(popup_key)
        return show_alert_success()

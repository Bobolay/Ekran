# $document.ready ->

#   login_button = $('.login-button')
#   login_popup = $('.login-popup-wrapper')
#   close_button = $('.login-popup-wrapper .close')

#   login_button.on 'click', ->

#     $('.mask-full ').addClass('visible ')
#     login_popup.addClass('visible')

#   $.clickOut('.login-popup-wrapper',
#     ()->
#       $('.login-popup-wrapper').removeClass('visible')
#       $('.mask-full ').removeClass('visible')
#     {except: '.login-popup-wrapper, .login-button'}
#   )

#   close_button.on 'click', ->
#     login_popup.removeClass('visible')
#     $('.mask-full ').removeClass('visible')



#   #     C A L L     U S     P O P U P

#   $('.top-nav-contact-button').on "click", ->
#     $('.call-us-popup').toggleClass("visible")

#   $('.call-us-popup .button').on "click", ->
#     $(this).css("color","#00A029")
#     $('.success').addClass("visible")
#     setTimeout (->
#       $('.success').removeClass("visible")
#     ), 3000
#     setTimeout (->
#       $('.call-us-popup .button').css("color","white")
#     ), 3800

#   $.clickOut(".call-us-popup",
#     ()->
#       $(".call-us-popup").removeClass('visible')
#     {except: ".top-nav-contact-button, .call-us-popup"}
#   )

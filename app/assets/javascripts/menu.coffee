$document.on 'click', '.menu-button, .close-menu', ->

  # $(this).toggleClass("opened")
  menu = $('.menu-wrapper')
  if menu.hasClass('opened')
    menu.removeClass('opened')
  else
    menu.addClass('opened')
  # $('.mask').toggleClass('visible')

# $.clickOut(".menu-wrapper",
#   ()->
#     $('.menu-button').removeClass('opened')
#     $('.mask').removeClass('visible')
#     $('.menu-wrapper').removeClass('opened')
#   {except: ".menu-wrapper, .menu-button"}
# )
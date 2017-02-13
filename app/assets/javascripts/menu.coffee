$document.on 'click', '.menu-button, .close-menu', ->

  header = $('.header-container')
  menu = $('.menu-wrapper')
  if menu.hasClass('opened') || header.hasClass('menu-opened')
    menu.removeClass('opened')
    header.removeClass('menu-opened')
  else
    menu.addClass('opened')
    header.addClass('menu-opened')
$document.on 'click', '.hamburger, .close-menu', ->

  header = $('.header-container')
  menu = $('.menu-wrapper')
  hamburger = $('.hamburger')
  if menu.hasClass('opened') || header.hasClass('menu-opened')
    menu.removeClass('opened')
    header.removeClass('menu-opened')
    hamburger.removeClass('is-active')
  else
    menu.addClass('opened')
    header.addClass('menu-opened')
    hamburger.addClass('is-active')
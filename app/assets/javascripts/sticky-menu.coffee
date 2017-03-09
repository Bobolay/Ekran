scroll = (e)->

  desired_distance = 110
  scroll_top = $document.scrollTop()

  menuViewportOffsetTop = menu_top - scroll_top

  if menu_top < (scroll_top + desired_distance)
    menu.addClass('fixed')
  else
    menu.removeClass('fixed')

menu = $('.side-menu')
menu_offset_top = menu.offset()
menu_top = menu_offset_top.top

if menu.length
  $(window).on "scrolldelta", scroll
# scroll = (e)->

#   scroll_top = $("body").scrollTop() || $(window).scrollTop()

#   main_nav = $('.main-nav-wrapper')
#   main_nav_height = main_nav.height()
#   main_nav_top = main_nav.offset().top

#   #     F I X E D     H E A D E R

#   header = $(".main-nav-container")
#   top_nav = $(".top-nav-container")
#   top_nav_height = top_nav.outerHeight()

#   if scroll_top > top_nav_height
#     header.addClass('fixed')
#   else
#     header.removeClass('fixed')

#   #     M E N U
#   menu = $('.menu-wrapper')
#   if scroll_top > top_nav_height
#     menu.css('top', scroll_top+main_nav_height)
#   else
#     menu.css('top', main_nav_height+main_nav_top)

#   #     S C H E M E     M E N U
#   scheme_menu = $('.scheme-container-desktop')
#   if scroll_top > top_nav_height
#     scheme_menu.css('top', scroll_top+main_nav_height)
#   else
#     scheme_menu.css('top', main_nav_height+main_nav_top)



# $(window).on "scrolldelta", scroll
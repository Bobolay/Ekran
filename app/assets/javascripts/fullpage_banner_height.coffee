$(document).on "ready", ->

  $screenWidth = $(window).width()
  $screenHeight = $(window).height()

  fullpage_banner = $('.fullpage-banner-wrapper')
  main_banner = $('.main-banner-wrapper')

  fullpage_banner.css('height', $screenHeight + 'px')
  main_banner.css('height', $screenHeight/2 + 'px')

  if $screenWidth > 640

    $(window).on "orientationchange", ->
      #     S E T     F U L L P A G E     B A N N E R     H E I G H T
      $screenHeight = $(window).height()
      fullpage_banner.css('height', $screenHeight + 'px')
      main_banner.css('height', $screenHeight/2 + 'px')
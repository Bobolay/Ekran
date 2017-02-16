$document.ready ->

  #     FOR MOBILE DEVICES SET ACTIVE PAGE ON HEAD OF LIST

  if width < 1024
    $('.partner-link.active').prependTo('.partner-link-container')

  #     THEN OPEN DROPDOWN LIST

    $('.partner-link.active').on "click", (e)->
      event.preventDefault()
      $(this).toggleClass('opened')
      $(this).closest('.partner-link-container').find('.partner-link').toggleClass('visible')

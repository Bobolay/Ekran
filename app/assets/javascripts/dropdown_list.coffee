$document.on "ready", ->
  
  #     FOR MOBILE DEVICES SET ACTIVE PAGE ON HEAD OF LIST

  if width < 1024
    $('.link.active').prependTo('.link-container')

  #     THEN OPEN DROPDOWN LIST

    $('.link.active').on "click", (e)->
      event.preventDefault()
      $(this).toggleClass('opened')
      $(this).closest('.link-container').find('.link').toggleClass('visible')

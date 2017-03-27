$document.on 'click', '.region-block', ->


  if $(this).hasClass('active')
    $(this).removeClass('active')
  else
    $(this).closest('.office-container').find('.region-block').removeClass('active')
    $(this).addClass('active')

  $.clickOut('.region-block',
    ()->
      $('.region-block').removeClass('active')
    {except: '.region-block'}
  )
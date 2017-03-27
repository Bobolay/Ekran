$document.on 'click', '.promotion-filter-field', ()->

  if $(this).hasClass('active')
    $(this).removeClass('active')
    $('.promotion-block').removeClass('hidden')
  else
    $(this).addClass('active')
    $('.promotion-block').addClass('hidden')
    $('.promotion-block.current').removeClass('hidden')
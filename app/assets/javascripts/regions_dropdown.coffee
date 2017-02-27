$document.on 'click', '.region-block', ->

  $(this).toggleClass('active')

  hidden_content = $(this).find('.hidden-content')
  hidden_content.slideToggle(350)
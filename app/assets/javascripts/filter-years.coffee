$( ".filter-years select" ).change(->
  selected = $(this).val()
  if selected == "all"
    $('.year-block').removeClass('hide')
  else
    $('.year-block').addClass('hide')
    $('.year-block[data-attr="' + selected + '"]').removeClass('hide')
)
$( ".filter-years select" ).change(->
  selected = this.options[this.selectedIndex].value
  if selected == "all"
    $('.year-block').removeClass('hide')
  else
    $('.year-block').addClass('hide')
    $('.year-block[data-attr="' + selected + '"]').removeClass('hide')
)
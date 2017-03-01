$("a[href^='#']").on "click", (e)->
  e.preventDefault()
  $link = $(this)
  href = $link.attr("href")
  target_top = $(href).offset().top
  $("body").animate({scrollTop: target_top})
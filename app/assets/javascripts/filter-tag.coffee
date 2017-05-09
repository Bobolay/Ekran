$document.on 'click', '.filter-container .filter', ()->

  $(this).toggleClass("active")
  tag_ids = $(this).closest(".filter-container").find(".filter.active").map(
    ()->
      $(this).attr("data-tag-id")
  ).toArray()

  if !tag_ids.length
    $(".project-block.hide").removeClass("hide")
    return

  $articles = $('.project-block')
  $articles_to_show = $articles.filter(
    ()->
      article_tag_ids = $(this).attr("data-tag-ids").split(',')
      matched = false
      for id in article_tag_ids
        matched = true if tag_ids.indexOf(id) >= 0

      matched
  )

  $articles.addClass('hide')
  $(".year-block").addClass('hide')

  $articles_to_show.removeClass('hide')


  $(".year-block").each(
    ()->
      $year_block = $(this)
      $projects_container = $year_block.next()
      has_visible_items = $projects_container.find(".project-block:not(.hide)").length > 0
      if has_visible_items
        $year_block.removeClass("hide")
  )

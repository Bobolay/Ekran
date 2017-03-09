filterProjects = (properties = {})->
  $projects = $(this)
  $projects.filter(
    ()->
      $project = $(this)

      for k, v of properties
        item_prop_values = $project.attr(k).split(",")
        return false if !item_prop_values.includes(v)

      return true
  )

$document.on "change", ".filter-years select", ()->
  
  properties = {}
  $select = $(this)
  value = $select.val()
  if value == "all" || value == ""
    return

  prop_name = $select.attr("data-prop-name")
  properties[prop_name] = value

  has_filters = has_keys(properties)

  $projects = $("projects-wrapper .year-block")

  if has_filters
    $projects.filter(":not(.hide)").addClass("hide")
    $matched_projects = filterProjects.call($projects, properties)
    $matched_projects.removeClass("hide")
  else
    $projects.filter(".hide").removeClass("hide")

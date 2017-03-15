#     S L I D E R     O P T I O N S

    # nextSelector: '.slider-next'
    # prevSelector: '.slider-prev'
    # nextText: '>'
    # prevText: '<'


# $document.on "ready page:load", ->
$document.on "ready", ->

  #     M A I N     B A N N E R     S L I D E R

  banner_slider = $('.fullpage-banner-slider').bxSlider
    controls: false
    pager: false
    speed: 1000
    pause: 10000
    auto: true
    onSlideBefore: ($slideElement, oldIndex, newIndex)->
      current = banner_slider.getCurrentSlide()
      $('.fullpage-banner-wrapper .custom-pager .current-slide').text((current+1))
      $('.banner-text').removeClass('visible')
      $('.banner-text').eq(current).addClass('visible')
  if banner_slider.getSlideCount
    $('.fullpage-banner-wrapper .custom-pager .total-slide').text((banner_slider.getSlideCount()))
  $('.fullpage-banner-wrapper .prev-slide').click ->
    banner_slider.goToPrevSlide()
  $('.fullpage-banner-wrapper .next-slide').click ->
    banner_slider.goToNextSlide()

  #     B R A N D S

  brands_slider = $('.brands-slider').bxSlider
    controls: false
    pager: false
    speed: 1000
    pause: 9000
    auto: true
    onSlideBefore: ($slideElement, oldIndex, newIndex)->
      current = brands_slider.getCurrentSlide()
      $('.brands-wrapper .custom-pager .current-slide').text((current+1))
      $('.brands-wrapper .bg-icon').removeClass('visible')
      $('.brands-wrapper .bg-icon').eq(current).addClass('visible')
      $('.brands-wrapper .bg-color').removeClass('visible')
      $('.brands-wrapper .bg-color').eq(current).addClass('visible')
  if brands_slider.getSlideCount
    $('.brands-wrapper .custom-pager .total-slide').text((brands_slider.getSlideCount()))
  $('.brands-wrapper .prev-slide').click ->
    brands_slider.goToPrevSlide()
  $('.brands-wrapper .next-slide').click ->
    brands_slider.goToNextSlide()
  
  #     M A I N     S L I D E R

  main_slider = $('.main-slider').bxSlider
    controls: false
    pager: false
    speed: 1000
    pause: 9000
    auto: true
    onSlideBefore: ($slideElement, oldIndex, newIndex)->
      current = main_slider.getCurrentSlide()
      $('.main-slider-wrapper .custom-pager .current-slide').text((current+1))
  if main_slider.getSlideCount
    $('.main-slider-wrapper .custom-pager .total-slide').text((main_slider.getSlideCount()))
  $('.main-slider-wrapper .prev-slide').click ->
    main_slider.goToPrevSlide()
  $('.main-slider-wrapper .next-slide').click ->
    main_slider.goToNextSlide()

  #     M E D I A     B A C K G R O U N D     S L I D E R

  media_slider = $('.media-background-slider').bxSlider
    controls: false
    pager: false
    speed: 1000
    pause: 10000
    auto: true
    onSlideBefore: ($slideElement, oldIndex, newIndex)->
      current = media_slider.getCurrentSlide()
      $('.main-banner-wrapper .custom-pager .current-slide').text((current+1))
      $('.related-to-slider-text').removeClass('visible')
      $('.related-to-slider-text').eq(current).addClass('visible')
  if media_slider.getSlideCount
    $('.main-banner-wrapper .custom-pager .total-slide').text((media_slider.getSlideCount()))
  $('.main-banner-wrapper .prev-slide').click ->
    media_slider.goToPrevSlide()
  $('.main-banner-wrapper .next-slide').click ->
    media_slider.goToNextSlide()
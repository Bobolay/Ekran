scroll_home_banner = function(top) {

    var $html_body = $('body, html')
    var $body = $("body")
    if(top < 0){
        top = 0
    }

    var scroll_top = $("body").scrollTop() || $(window).scrollTop()

    if(scroll_top != top && !$body.data("scroll_in_progress")) {
        $html_body.stop()
        $body.data("scroll_in_progress", true)

        $body.data("scroll_top", top)



        $html_body.animate(
            {scrollTop: top},
            {
                duration: 1000,
                easing: "easeInOutQuad",
                //specialEasing: "easeInOutElastic"
                complete: function(){
                    $body.data("scroll_in_progress", false)
                }
            }
        )
    }
}

$('.go-down').on("click", function(){
    var $slider = $(".fullpage-banner-wrapper:first")
    var slider_height = $slider.first().height()
    var $next_section = $slider.next()
    var next_section_top = $next_section.offset().top
    scroll_home_banner(next_section_top)
})

$("body").on("wheel", function(e){

    if(e && e.ctrlKey) {
        return true
    }
    var $slider = $(".fullpage-banner-wrapper:first")
    if($slider.length == 0){
        return;
    }
    var slider_height = $slider.first().height()
    var $next_section = $slider.next()
    var next_section_top = $next_section.offset().top

    var scroll_top = $("body").scrollTop() || $(window).scrollTop()
    scroll_top = Math.ceil(scroll_top)
    var diff = next_section_top - scroll_top

    if( scroll_top < next_section_top  && e.originalEvent.deltaY > 0){
        e.preventDefault()
        scroll_home_banner(next_section_top)
    }
})
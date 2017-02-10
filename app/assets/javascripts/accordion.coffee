$document.on 'click', '.accordion-button', (e)->

    e.preventDefault()
    
    $this = $(this)

    #     b u t t o n

    if $this.hasClass('opened')
        $this.removeClass('opened')
    else
        $this.siblings().removeClass('opened')
        $this.addClass('opened')
  
    #     a c c o r d i o n

    if $this.next().hasClass('show')
        $this.next().removeClass('show')
        $this.next().slideUp(350)
    else
        $this.parent().parent().find('.accordion-inner').removeClass('show')
        $this.parent().parent().find('.accordion-inner').slideUp(350)
        $this.next().toggleClass('show')
        $this.next().slideToggle(350)
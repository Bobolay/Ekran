$document.on 'click', '.accordion-button', (e)->

    e.preventDefault()

    if width < 640
    
        $this = $(this)

        #     b u t t o n

        if $this.hasClass('opened')
            $this.removeClass('opened')
        else
            $this.closest('.year-block').find('.accordion-button').removeClass('opened')
            $this.closest('.year-block').siblings().find('.accordion-button').removeClass('opened')
            $this.addClass('opened')
      
        #     a c c o r d i o n

        if $this.next().hasClass('show')
            $this.next().removeClass('show')
            $this.next().slideUp(350)
        else
            $this.closest('.year-block').find('.accordion-inner').removeClass('show')
            $this.closest('.year-block').find('.accordion-inner').slideUp(350)
            $this.closest('.year-block').siblings().find('.accordion-inner').removeClass('show')
            $this.closest('.year-block').siblings().find('.accordion-inner').slideUp(350)
            $this.next().toggleClass('show')
            $this.next().slideToggle(350)

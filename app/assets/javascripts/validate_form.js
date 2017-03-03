$().ready(function(){
  $("form.validate").each(function(){
      $(this).validate({
          rules: {
              firstname: "required",
              email: {
                  required: true,
                  email: true
              },
              phone: "required",
              address: "required"
          },
      })
  })


})
$().ready(function(){

  $("form.validate").validate({
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
$().ready(function(){

  $("form").validate({
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
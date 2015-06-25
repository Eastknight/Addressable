$ ->
  ##Clinet Side Validation
  $.validator.addMethod 'customemail', ((value, element) ->
    /^[^@\s]+@([^@\s]+\.)+[^@\W]+$/.test value
    ), 'Invalid Email.'

  $.validator.addMethod 'passwordMatch', ((value, element) ->
  # The two password inputs
    password = $('#user_password').val()
    confirmPassword = $('#user_password_confirmation').val()
    # Check for equality with the password inputs
    if password != confirmPassword
      false
    else
      true
    ), 'Your Passwords Must Match.'
  
  $('.signup-form').validate
    rules: 
      "user[email]":
        required: true
        email: true
        customemail: true
        remote:
          url: '/users/check-email'
      "user[password]":
        required: true
        minlength: 8
      "user[password_confirmation]":
        passwordMatch: true
    errorPlacement: (label, element) ->
      label.insertAfter element
      return
    wrapper: 'span'
    messages:
      "user[email]":
        email: "Invalid Email."
        remote: "This email already exists."
  
  return

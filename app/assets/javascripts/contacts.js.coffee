$ ->
  #config best_in_place
  $('.best_in_place').best_in_place()
  
  ##Add callbacks to in-line editing errors
  $('.contact-email').bind 'ajax:error', ->
    alert("Email is not valid.")
    return
  $('.contact-phone').bind 'ajax:error', ->
    alert("Phone number is not valid. We only support US phone number")
    return
  $('.contact-name').bind 'ajax:error', ->
    alert("Name can't be blank!")
    return
  
  ##Filter contacts list
  #pagination
  $('#lists').on 'click', '.pagination a', ->
    $.getScript @href
    false
  #search
  $('#searchform input').keyup ->
    data = $('#searchform').serialize()
    if ($('#toggal #all-contacts').length)
      data = data + '&showFriends=' + "true"
    $.get $('#searchform').attr('action'), data, null, 'script'
    false
  #Show friends list
  $('#toggal').on 'click', '#show-friend', ->
    $.get @herf, { showFriends: true }, (->
      $('#show-friend').replaceWith('<button class="btn btn-primary" id="all-contacts">All Contacts</button>')
    ), 'script'
    false
  $('#toggal').on 'click', '#all-contacts', ->
    $.get @herf, { showFriends: false }, (->
      $('#all-contacts').replaceWith('<button class="btn btn-primary" id="show-friend">Show Friends</button>')
    ), 'script'
    false

  #Clinet Side Validation
  $.validator.addMethod 'customemail', ((value, element) ->
    /^[^@\s]+@([^@\s]+\.)+[^@\W]+$/.test value
    ), 'Please enter a valid email address.'

  $('#new-contact-form').validate
    rules: 
      "contact[email]":
        required: true
        email: true
        customemail: true
        remote:
          url: '/contacts/check-email'
      "contact[name]":
        required: true
        minlength: 1
      "contact[phone]":
        required: true
        phoneUS: true
        remote:
          url: '/contacts/check-phone'
    errorPlacement: (label, element) ->
      label.insertAfter element
      return
    wrapper: 'span'
    messages:
      "contact[email]":
        remote: "This email already exists."
      "contact[phone]":
        remote: "This number already exists."
  
  #Friend and Un-friend
  $('.submittable').on 'click', ->
    $(this).parents('form:first').submit()

  return
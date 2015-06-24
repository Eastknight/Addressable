# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# # You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  #config best_in_place
  $('.best_in_place').best_in_place()
  
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
  $('#new-contact-form').validate
    rules: 
      "contact[email]":
        required: true
        email: true
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
    messages:
      "contact[email]":
        remote: "This email already exists."
      "contact[phone]":
        remote: "This number already exists."
  
  #Friend and Un-friend
  $('.submittable').on 'click', ->
    $(this).parents('form:first').submit()

  return
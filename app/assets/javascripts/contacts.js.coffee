# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  #config best_in_place
  $('.best_in_place').best_in_place()

  $('#lists').on 'click', '.pagination a', ->
    $.getScript @href
    false
  $('#searchform input').keyup ->
    $.get $('#searchform').attr('action'), $('#searchform').serialize(), null, 'script'
    false
  $('#new-contact-form').validate
    debug: true 
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

  return
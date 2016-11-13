# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('#invoice_date_of_issue, #invoice_deadline, #invoice_payment_date').datepicker
    dateFormat: 'dd-mm-yy'

  $('form').on 'click', '.remove_fields', (event) ->
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('fieldset').hide()
    event.preventDefault()

  $('form').on 'click', '.add_fields', (event) ->
    id = $('.taxable').length + 1
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, id))
    event.preventDefault()

  $('form').on 'click', '.add_vehicle_fields', (event) ->
    id = $('.taxable').length + 1
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, id))
    event.preventDefault()

# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#
$ ->
  $('#insurance_date_of_issue, #insurance_deadline ').datepicker
    dateFormat: 'dd-mm-yy'

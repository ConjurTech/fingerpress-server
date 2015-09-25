# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  $('#pay_scheme_ot_multiplier_div').hide()
  $('#pay_scheme_pay_ot_div').hide()
  showorhidedivs()

jQuery ->
  $('#pay_scheme_ot_type_id.select').change ->
    showorhidedivs()

showorhidedivs = ->
  if $('#pay_scheme_ot_type_id.select option:selected').text() == "PerHour"
    $('#pay_scheme_ot_multiplier_div').hide()
    $('#pay_scheme_pay_ot_div').show()
    $('#pay_scheme_ot_multiplier').val('')


  else if $('#pay_scheme_ot_type_id.select option:selected').text() == "Multiplier"
    $('#pay_scheme_ot_multiplier_div').show()
    $('#pay_scheme_pay_ot_div').hide()
    $('#pay_scheme_pay_ot').val('')

  else if $('#pay_scheme_ot_type_id.select option:selected').text() == "None"
    $('#pay_scheme_ot_multiplier_div').hide()
    $('#pay_scheme_pay_ot_div').hide()
    $('#pay_scheme_pay_ot').val('')
    $('#pay_scheme_ot_multiplier').val('')
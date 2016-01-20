# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  $('#pay_scheme_ot_multiplier_div').hide()
  $('#pay_scheme_pay_ot_div').hide()
  $('#pay_scheme_ot_time_div').hide()
  $('#pay_scheme_ph_multiplier_div').hide()
  $('#pay_scheme_pay_ph_div').hide()
  $('#pay_scheme_w_multiplier_div').hide()
  $('#pay_scheme_pay_w_div').hide()
  ShowOrHideOtDivs()
  ShowOrHidePhDivs()
  ShowOrHideWDivs()

jQuery ->
  $('#pay_scheme_ot_type.select').change ->
    ShowOrHideOtDivs()

  $('#pay_scheme_public_holiday_type.select').change ->
    ShowOrHidePhDivs()

  $('#pay_scheme_weekend_type.select').change ->
    ShowOrHideWDivs()


ShowOrHideOtDivs = ->
  if $('#pay_scheme_ot_type.select option:selected').text() == "Per Hour"
    $('#pay_scheme_ot_multiplier_div').hide()
    $('#pay_scheme_pay_ot_div').show()
    $('#pay_scheme_ot_time_div').show()
    $('#pay_scheme_ot_multiplier').val('')


  else if $('#pay_scheme_ot_type.select option:selected').text() == "Multiplier"
    $('#pay_scheme_ot_multiplier_div').show()
    $('#pay_scheme_ot_time_div').show()
    $('#pay_scheme_pay_ot_div').hide()
    $('#pay_scheme_pay_ot').val('')

  else if $('#pay_scheme_ot_type.select option:selected').text() == "Same As Normal"
    $('#pay_scheme_ot_multiplier_div').hide()
    $('#pay_scheme_pay_ot_div').hide()
    $('#pay_scheme_pay_ot').val('')
    $('#pay_scheme_ot_multiplier').val('')
    $('#pay_scheme_ot_time_div').hide()

ShowOrHidePhDivs = ->
  if $('#pay_scheme_public_holiday_type.select option:selected').text() == "Per Hour"
    $('#pay_scheme_ph_multiplier_div').hide()
    $('#pay_scheme_pay_ph_div').show()
    $('#pay_scheme_public_holiday_multiplier').val('')

  else if $('#pay_scheme_public_holiday_type.select option:selected').text() == "Multiplier"
    $('#pay_scheme_ph_multiplier_div').show()
    $('#pay_scheme_pay_ph_div').hide()
    $('#pay_scheme_pay_public_holiday').val('')

  else if $('#pay_scheme_public_holiday_type.select option:selected').text() == "Same As Normal"
    $('#pay_scheme_ph_multiplier_div').hide()
    $('#pay_scheme_pay_ph_div').hide()
    $('#pay_scheme_pay_public_holiday').val('')
    $('#pay_scheme_public_holiday_multiplier').val('')

ShowOrHideWDivs = ->
  if $('#pay_scheme_weekend_type.select option:selected').text() == "Per Hour"
    $('#pay_scheme_w_multiplier_div').hide()
    $('#pay_scheme_pay_w_div').show()
    $('#pay_scheme_weekend_multiplier').val('')

  else if $('#pay_scheme_weekend_type.select option:selected').text() == "Multiplier"
    $('#pay_scheme_w_multiplier_div').show()
    $('#pay_scheme_pay_w_div').hide()
    $('#pay_scheme_pay_weekend').val('')

  else if $('#pay_scheme_weekend_type.select option:selected').text() == "Same As Normal"
    $('#pay_scheme_w_multiplier_div').hide()
    $('#pay_scheme_pay_w_div').hide()
    $('#pay_scheme_pay_weekend').val('')
    $('#pay_scheme_weekend_multiplier').val('')
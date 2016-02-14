# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  if $('.config-edit-form')[0]
    adjust_start_time_checked = $('#config_auto_adjust_start_time')[0].checked
    adjust_end_time_checked = $('#config_auto_adjust_end_time')[0].checked
    disable_check_in_configs(!adjust_start_time_checked)
    disable_check_out_configs(!adjust_end_time_checked)
    $('#config_auto_adjust_start_time').click ->
      disable_check_in_configs(!@checked)
    $('#config_auto_adjust_end_time').click ->
      disable_check_out_configs(!@checked)

disable_check_in_configs = (bool) ->
  $('#config_start_time_lower_tolerance').attr 'disabled', bool
  $('#config_start_time_lower_tolerance').material_select()
  $('#config_start_time_upper_tolerance').attr 'disabled', bool
  $('#config_start_time_upper_tolerance').material_select()

disable_check_out_configs = (bool) ->
  $('#config_end_time_lower_tolerance').attr 'disabled', bool
  $('#config_end_time_lower_tolerance').material_select()
  $('#config_end_time_upper_tolerance').attr 'disabled', bool
  $('#config_end_time_upper_tolerance').material_select()
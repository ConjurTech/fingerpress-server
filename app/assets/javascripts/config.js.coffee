# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  if $('.config-edit-form')[0]
    checked = $('#config_auto_adjust_to_workday')[0].checked
    disable_other_configs(!checked)
    $('#config_auto_adjust_to_workday').click ->
      disable_other_configs(!@checked)

disable_other_configs = (bool) ->
  $('#config_lower_timing_tolerance').attr 'disabled', bool
  $('#config_lower_timing_tolerance').material_select()
  $('#config_upper_timing_tolerance').attr 'disabled', bool
  $('#config_upper_timing_tolerance').material_select()
  $('#config_ignore_early_check_in').attr 'disabled', bool
# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->
  if $('.time_log_config-edit-form')[0]
    adjust_start_time_checked = $('#time_log_config_auto_adjust_start_time')[0].checked
    adjust_end_time_checked = $('#time_log_config_auto_adjust_end_time')[0].checked
    disable_check_in_time_log_configs(!adjust_start_time_checked)
    disable_check_out_time_log_configs(!adjust_end_time_checked)
    $('#time_log_config_auto_adjust_start_time').click ->
      disable_check_in_time_log_configs(!@checked)
    $('#time_log_config_auto_adjust_end_time').click ->
      disable_check_out_time_log_configs(!@checked)

disable_check_in_time_log_configs = (bool) ->
  $('#time_log_config_start_time_lower_tolerance').attr 'disabled', bool
  $('#time_log_config_start_time_lower_tolerance').material_select()
  $('#time_log_config_start_time_upper_tolerance').attr 'disabled', bool
  $('#time_log_config_start_time_upper_tolerance').material_select()

disable_check_out_time_log_configs = (bool) ->
  $('#time_log_config_end_time_lower_tolerance').attr 'disabled', bool
  $('#time_log_config_end_time_lower_tolerance').material_select()
  $('#time_log_config_end_time_upper_tolerance').attr 'disabled', bool
  $('#time_log_config_end_time_upper_tolerance').material_select()
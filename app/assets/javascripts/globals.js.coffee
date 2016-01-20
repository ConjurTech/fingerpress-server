$(document).ready ->
  $('.datepicker').pickadate
    selectMonths: true
    selectYears: 100

  $('select').material_select()
  $('.clockpicker').clockpicker({
    autoclose: false
    twelvehour: true
    donetext: 'Done'
  });

  $('.timepicker').pickatime()


# For fade in fade out effect between pages
$(document).on 'page:fetch', ->
  $('.container').fadeOut 'slow'

$(document).on 'page:change', ->
  $('.container').hide()
  $('.container').fadeIn 'slow'
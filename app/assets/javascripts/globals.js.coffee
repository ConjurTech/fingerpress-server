$(document).ready ->
  $('.datepicker').pickadate
    selectMonths: true
    selectYears: 50

  $('select').material_select()

  $('.clockpicker').clockpicker({
    autoclose: false
    twelvehour: true
    donetext: 'Done'
  });

  $('.timepicker').pickatime()


# For fade in fade out effect between pages
$(document).on 'page:fetch', ->
  $('.container').fadeOut 'fast'
  $('.materialize-preloader').show()

$(document).on 'page:change', ->
  $('.container').hide()
  $('.container').fadeIn 'slow'
  $('.materialize-preloader').hide()
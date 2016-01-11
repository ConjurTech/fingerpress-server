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


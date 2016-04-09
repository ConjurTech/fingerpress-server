$(document).ready ->
  console.log $('.pay_scheme_dropdown').val()

$(document).on 'change', '#pay_scheme_ids', ->
  $this = $(this)
  ids = $this.val()
  console.log ids
  $.ajax
    url: "/employees.json"
    data:
      pay_scheme_id: ids
    success: (data, status) ->
      employee_select = $('#pay_roll_employee_ids')
      employee_select.material_select('destroy')
      employee_select.empty()
      data.forEach (entry)->
        employee_select.append($("<option></option>").attr("value",entry.id).text(entry.name));
      employee_select.material_select()

$(document).on 'click', '.select-all-employees-btn', ->
  employee_select = $('#pay_roll_employee_ids')
  employee_select.material_select('destroy')
  $('#pay_roll_employee_ids option').prop('selected', true)
  employee_select.material_select()

$(document).on 'click', '.select-all-pay-schemes-btn', ->
  pay_scheme_select = $('#pay_scheme_ids')
  pay_scheme_select.material_select('destroy')
  $('#pay_scheme_ids option').prop('selected', true)
  pay_scheme_select.material_select()
  pay_scheme_select.trigger('change')
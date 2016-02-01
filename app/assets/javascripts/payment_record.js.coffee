$(document).on 'change', '.pay_scheme_dropdown', ->
  $this = $(this)
  id = $this.val()
  $.ajax
    url: "/employees.json"
    data:
      pay_scheme_id: id
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
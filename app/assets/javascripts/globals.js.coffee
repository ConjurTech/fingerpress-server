$(document).on 'turbolinks:load', ->
  initializeAll()
  $('.container').fadeIn 'slow'
  $('.materialize-preloader').hide()

initializeAll = ->
# initialize all select boxes with selectize
#  $('.selectize').selectize
#    selectOnTab: true
#    plugins: ['remove_button']
  $('select').material_select()

  # initialize all modals
  $('.modal-trigger').leanModal()

  # initialize side nav button on mobile
  $(".button-collapse").sideNav()

  # initialize all dropdown in li
  $(".dropdown-button").dropdown()

  # initialize all collapsibles
  $('.collapsible').collapsible()

  # reinitialize form label
  Materialize.updateTextFields()

  # reinitialize wave effect on button
  Waves.displayEffect()

  # initialize notification sidebar
  if $(".notification-nav")[0]
    $(".notification-nav").sideNav
      menuWidth: 350
      edge: 'right'

  # Initialize Filterrific
#  $('#filterrific_filter').on "change", ":input", Filterrific.submitFilterForm
#  $(".filterrific-periodically-observed").filterrific_observe_field(0.5, Filterrific.submitFilterForm);

  # initialize auto disappearing notice whenever an action occurs
  $('.notice').delay(3500).animate {
      opacity: 'hide',
      margin: 'hide',
      'padding-top': 'hide',
      'padding-bottom': 'hide',
      height: 'hide'
    }, 1000, ->
    $(this).remove()

  # Stop filterrific from submitting a form
#  $('#filterrific_filter input').on 'keypress', (e) ->
#    return false if e.keyCode == 13

  # initialize all time related pickers
  $('.timepicker').pickatime()
  $('.datepicker').pickadate
    selectMonths: true
    selectYears: true
  $('.clockpicker').clockpicker
    twelvehour: true
    donetext: 'Done'

# For fade in fade out effect between pages
#$(document).on 'page:fetch', ->
#  $('.container').fadeOut 'fast'
#  $('.materialize-preloader').show()
#
#$(document).on 'page:change', ->
#  $('.container').hide()

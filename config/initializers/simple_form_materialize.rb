# Use this setup block to configure all options available in SimpleForm.
SimpleForm.setup do |config|
  config.error_notification_tag = 'blockquote'
  config.error_notification_class = 'error-notification'
  config.button_class = 'waves-effect waves-light btn'
  config.boolean_label_class = nil
  config.boolean_style = :inline

  config.wrappers :vertical_input, tag: 'div', class: 'input-field', error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :input
    b.use :label
    b.use :error, wrap_with: { tag: 'span', class: 'error-block' }
    b.use :hint,  wrap_with: { tag: 'span', class: 'help-block' }
  end

  config.wrappers :vertical_form_div, tag: 'div', class: 'input-field-static', error_class: 'has-error' do |b|
    b.use :html5
    b.optional :readonly

    b.use :label_input
    b.use :error, wrap_with: { tag: 'span', class: 'error-block' }
    b.use :hint,  wrap_with: { tag: 'span', class: 'help-block' }
  end

  config.wrappers :vertical_form_p, tag: 'p', class: 'input-field-static', error_class: 'has-error' do |b|
    b.use :html5
    b.optional :readonly

    b.use :input
    b.use :label
    b.use :error, wrap_with: { tag: 'span', class: 'error-block' }
    b.use :hint,  wrap_with: { tag: 'span', class: 'help-block' }
  end

  config.default_wrapper = :vertical_input
  config.wrapper_mappings = {
      check_boxes: :vertical_form_p,
      radio_buttons: :vertical_form_p,
      file: :vertical_input,
      boolean: :vertical_form_p,
      select: :vertical_form_div,
      text: :vertical_form_div
  }

end
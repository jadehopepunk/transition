class LabelledBuilder < BaseBuilder
  ACRONYMS = [:url]

  def self.create_labelled_field(method_name)
    define_method(method_name) do |label, *args|
      options = {}
      args ||= []
      if args.last.is_a?(Hash)
        options = args.last
      else
        args << {}
      end
      
      hint = options[:hint]
      label_override = options[:label]
      other_validation_fields = options[:other_validation_fields]
      css_class = [options[:class], method_name.to_s].compact.join(' ')
      args.last[:class] = css_class if args && args.last
      
      field_human_name = label_override ? label_override : (ACRONYMS.include?(label) ? label.to_s.upcase : label.to_s.humanize.titleize)
      
      label_inner_text = field_human_name
      if hint
        hint_text = @template.content_tag('span', "(#{hint})", :class => 'hint')
        label_inner_text += ' ' + hint_text
      end
      label_text = @template.content_tag('label', label_inner_text, :for => "#{@object_name}_#{label}", :class => css_class)
      
      field_text = super(label, *args)
      
      error_fields = [label]
      error_fields += other_validation_fields if other_validation_fields
      error_text = error_fields.map do |error_field|
        @template.error_message_on(@object_name, error_field, "<strong>Sorry</strong>, #{field_human_name} ")
      end
      error_text = error_text.join(' ')
      
      if method_name == 'check_box'
        contents = field_text + label_text + error_text
      else
        contents = label_text + error_text + field_text
      end
      
      @template.content_tag('div', contents, :class => 'form_row')
    end
  end
  
  (field_helpers + [:select, :image_selector, :rating_selector, :textile_editor]).uniq.each do |name|
    create_labelled_field(name) unless name == 'hidden_field'
  end

end
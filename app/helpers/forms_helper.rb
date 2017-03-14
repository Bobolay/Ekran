module FormsHelper
  def input(resource_name, input_name, options = {})
    input_name = input_name.to_s
    defaults = {
        type: :string,
        required: false
    }
    options = defaults.merge(options)
    options[:input_html] ||= {}

    options[:type] = :email if input_name == "email"
    options[:type] = :tel if input_name == "phone"

    html_name = "#{resource_name}[#{input_name}]"
    html_input_id = "#{resource_name}__#{input_name}"
    input_type = options[:type]
    input_type = :text if options[:type] == :string

    wrap_html = {
        class: "input-field"
    }

    wrap_html[:class] += " input-#{options[:type]}"

    input_html_attributes = {name: html_name, id: html_input_id, type: input_type }.merge(options[:input_html])

    label_html_attributes = { for: html_input_id, class: "placeholder" }
    label_text = I18n.t("forms.#{resource_name}.#{input_name}", raise: true) rescue I18n.t("forms.#{input_name}", raise: true) rescue input_name.humanize
    label_text = input_name.humanize if label_text.blank?
    if options[:required]
      input_html_attributes[:required] = "required"
      label_text = label_text + "<span>&nbsp;*</span>"
    end

    if options[:type] == :text
      input_html_attributes.delete(:type)
    end

    input_html_attributes_str = input_html_attributes.map{|k, v| "#{k}='#{v}'" }.join(' ')

    if options[:type] == :text
      input_tag_str = "<textarea #{input_html_attributes_str}></textarea>"
    else
      input_tag_str = "<input #{input_html_attributes_str} />"
    end

    label_html_attributes_str = label_html_attributes.map{|k, v| "#{k}='#{v}'" }.join(' ')

    wrap_html_attributes_str = wrap_html.map{|k, v| "#{k}='#{v}'" }.join(' ')


    label_str = "<label #{label_html_attributes_str}>#{label_text}</label>"
    "<div #{wrap_html_attributes_str}>#{input_tag_str}#{label_str}</div>".html_safe
  end
end
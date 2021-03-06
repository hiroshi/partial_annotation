# PartialAnnotation
ActionView::Partials.module_eval do
  def render_partial_with_annotation(options={})
    original = render_partial_without_annotation(options)
    case options[:partial]
    when String, Symbol, NilClass
      path = _pick_partial_template(options[:partial]).template_path
      "\n<!-- begin partial \"#{path}\" -->\n#{original}\n<!-- end partial \"#{path}\" -->\n"
    else
      original
    end
  end
  alias_method_chain :render_partial, :annotation
end

require 'test_helper'

class PartialAnnotationTest < ActiveSupport::TestCase
  def setup
    @view = ActionView::Base.new("#{File.dirname(__FILE__)}/fixtures/template")#, {}, ActionController::Base.new)
  end

  test "basic" do
    result = @view.render(:inline => <<-INLINE)
before partial
  <%= render :partial => '/foo' %>
after partial
    INLINE

    assert_equal result, <<-RESULT
before partial
  
<!-- begin partial "_foo.html.erb" -->
foo

<!-- end partial "_foo.html.erb" -->

after partial
    RESULT
  end

  test "with form_builder" do
    form = ActionView::Helpers::FormBuilder.new(:foo, @foo, @view, {}, Proc.new{})
    @view.instance_variable_set("@form", form)
    result = @view.render(:inline => <<-INLINE)
before partial
  <%= render :partial => @form %>
after partial
    INLINE

    assert_equal result, <<-RESULT
before partial
  
<!-- begin partial "_form.html.erb" -->
form

<!-- end partial "_form.html.erb" -->

after partial
    RESULT
  end
end

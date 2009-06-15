require 'test_helper'

class PartialAnnotationTest < ActiveSupport::TestCase
  test "basic" do
    @view = ActionView::Base.new("#{File.dirname(__FILE__)}/fixtures/template")
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
end

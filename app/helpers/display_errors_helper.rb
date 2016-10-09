module DisplayErrorsHelper
  def display_errors(flash)
    if flash[:error]
      content_tag :div, class:"error" do
        javascript_include_tag("error.js")
        content_tag(:h4, flash[:error] )
      end
    elsif flash[:success]
      content_tag :div, class:"success" do
        javascript_include_tag("success.js")
        content_tag(:h4, flash[:success] )
      end
    elsif flash[:notice]
      content_tag :div, class:"success" do
        javascript_include_tag("success.js")
        content_tag(:h4, flash[:notice])
      end
    end
  end
end

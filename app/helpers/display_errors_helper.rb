module DisplayErrorsHelper
  def display_errors(flash)
    if flash[:error]
      error
    elsif flash[:success]
      success
    elsif flash[:notice]
      notice
    end
  end

  private

  def error
    content_tag :div, class: 'error' do
      javascript_include_tag('error.js')
      content_tag(:h4, flash[:error])
    end
  end

  def success
    content_tag :div, class: 'success' do
      javascript_include_tag('success.js')
      content_tag(:h4, flash[:success])
    end
  end

  def notice
    content_tag :div, class: 'success' do
      javascript_include_tag('success.js')
      content_tag(:h4, flash[:notice])
    end
  end
end

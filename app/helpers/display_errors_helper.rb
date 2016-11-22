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
    content_tag :div, class: 'error visible' do
      content_tag(:h4, flash[:error])
    end
  end

  def success
    content_tag :div, class: 'success visible' do
      content_tag(:h4, flash[:success])
    end
  end

  def notice
    content_tag :div, class: 'success visible' do
      content_tag(:h4, flash[:notice])
    end
  end
end

module Features
  def visit_invoice_page
    visit '/'
    click_link 'Fatture'
  end
end

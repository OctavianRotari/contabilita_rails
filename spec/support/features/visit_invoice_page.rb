module Features
  def visit_invoice_page
    visit '/'
    click_link 'Fatture'
  end

  def visits_new_invoice
    visit '/'
    click_link 'Aziende'
    click_link 'Bezzi'
    click_link 'Aggiungi fattura'
  end
end

module Features
  def visit_active_invoices_page
    visit '/invoices/dashboard'
    find('#fatture').click
    click_link 'Fatture attive'
  end

  def visit_passive_invoices_page
    visit '/invoices/dashboard'
    find('#fatture').click
    click_link 'Fatture passive'
  end

  def visits_new_invoice
    visit '/invoices/dashboard'
    find('#fatture').click
    click_link 'Aggiungi fattura'
  end

end

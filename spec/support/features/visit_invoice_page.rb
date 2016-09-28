module Features
  def visit_active_invoices_page
    sign_up
    visit '/invoices/dashboard'
    click_link 'Fatture attive'
  end

  def visit_passive_invoices_page
    sign_up
    visit '/invoices/dashboard'
    click_link 'Fatture passive'
  end

  def visits_active_invoices(type_of_category, id)
    sign_up
    visit '/invoices/dashboard'
    click_link type_of_category
    page.find(id).click
    click_link 'Attive'
  end

  def visits_passive_invoices(type_of_category, id)
    sign_up
    visit '/invoices/dashboard'
    click_link type_of_category
    page.find(id).click
    click_link 'Passive'
  end

  def visits_new_invoice
    sign_up
    visit '/invoices/dashboard'
    click_link 'Aggiungi fattura'
  end

  def visits_individual_invoice
    sign_up
    visit '/invoices/dashboard'
    click_link 'Aziende'
    click_link "Fatture"
    click_link 'Fatture passive'
    click_link 'Manutenzione'
  end
end

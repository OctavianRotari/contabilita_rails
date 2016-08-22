module Features
  def visit_active_invoices_page
    visit '/'
    click_link 'Fatture attive'
  end

  def visit_passive_invoices_page
    visit '/'
    click_link 'Fatture passive'
  end

  def visits_active_invoices(type_of_category)
    visit '/'
    click_link type_of_category
    click_link 'Fatture'
    click_link 'Fatture attive'
  end

  def visits_passive_invoices(type_of_category)
    visit '/'
    click_link type_of_category
    click_link "Fatture"
    click_link 'Fatture passive'
  end

  def visits_new_invoice
    visit '/'
    click_link 'Aziende'
    click_link "Fatture"
    click_link 'Aggiungi fattura'
  end

  def visits_individual_invoice
    visit '/'
    click_link 'Aziende'
    click_link "Fatture"
    click_link 'Fatture passive'
    click_link 'Manutenzione'
  end
end

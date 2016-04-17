module Features
  def visit_invoice_page
    visit '/'
    click_link 'Fatture'
  end

  def visits_company
    visit '/'
    click_link 'Aziende'
    click_link 'Bezzi'
  end

  def visits_new_invoice
    visit '/'
    click_link 'Aziende'
    click_link 'Bezzi'
    click_link 'Aggiungi fattura'
  end

  def visits_individual_invoice
    visit '/'
    click_link 'Aziende'
    click_link 'Bezzi'
    click_link 'Manutenzione'
  end
end

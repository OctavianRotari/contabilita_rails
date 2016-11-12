module Features
  def fill_in_new_invoice(type_of_invoice)
    fill_in 'invoice[taxable_vat_fields_attributes][1][taxable]', with: 110
    page.select '10', from: 'invoice[taxable_vat_fields_attributes][1][vat_rate]'
    page.execute_script("$('#invoice_date_of_issue').val('2016-05-10')")
    page.select type_of_invoice, from: 'invoice[type_of_invoice]'
    page.select 'ER354BS', from: 'invoice[at_the_expense_of]'
    page.select 'Esso', from: 'invoice[company_id]'
    page.execute_script("$('#invoice_deadline').val('2016-05-30')")
    fill_in 'invoice[reason]', with: 'Manutenzione'
    click_button 'Conferma'
  end
end

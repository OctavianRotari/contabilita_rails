module Features
  def fill_in_new_invoice
    fill_in 'invoice[taxable]', with: 250
    page.select '22', from: 'invoice[vat_rate]'
    page.execute_script("$('#invoice_date_of_issue').val('2016-05-10')")
    page.select 'ER354BS', from: 'invoice[vehicle_id]'
    page.execute_script("$('#invoice_deadline').val('2016-05-30')")
    fill_in 'invoice[reason]', with: "Manutenzione"
  end
end

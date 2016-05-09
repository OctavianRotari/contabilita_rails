module Features
  def fill_in_new_invoice
    fill_in 'invoice[taxable_1]', with: 250
    page.select '22', from: 'invoice[vat_1]'
    fill_in 'invoice[date_of_issue]', with: "01/04/2015"
    page.select 'ER354BS', from: 'invoice[vehicle_id]'
    fill_in 'invoice[deadline]', with: "01/05/2015"
    fill_in 'invoice[reason]', with: "Manutenzione"
  end
end

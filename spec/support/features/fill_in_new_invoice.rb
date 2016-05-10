module Features
  def fill_in_new_invoice
    fill_in 'invoice[taxable_1]', with: 250
    page.select '22', from: 'invoice[vat_1]'
    select '2016', from: 'invoice[date_of_issue(1i)]'
    select 'March', from: 'invoice[date_of_issue(2i)]'
    select '1', from: 'invoice[date_of_issue(3i)]'
    page.select 'ER354BS', from: 'invoice[vehicle_id]'
    select '2016', from: 'invoice[date_of_issue(1i)]'
    select 'May', from: 'invoice[date_of_issue(2i)]'
    select '1', from: 'invoice[date_of_issue(3i)]'
    fill_in 'invoice[reason]', with: "Manutenzione"
  end
end

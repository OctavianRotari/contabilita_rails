module Features
  def fill_in_new_invoice
    fill_in 'invoice[taxable_1]', with: 250
    page.select '22', from: 'invoice[vat_1]'
    fill_in 'invoice[date]', with: "01/04/2015"
    fill_in 'invoice[plate]', with: "EG324FR"
    fill_in 'invoice[deadline]', with: "01/05/2015"
    fill_in 'invoice[method_of_payment]', with: "bonifico"
  end
end

module Features
  def fill_in_fuel_receipt(company_name='Esso', vehicle_plate='ER354BS')
    visit '/fuel_receipts/new'
    fill_in 'fuel_receipt[total]', with: '300'
    fill_in 'fuel_receipt[litres]', with: '200'
    page.select company_name, from: 'fuel_receipt[company_id]'
    page.select vehicle_plate, from: 'fuel_receipt[vehicle_id]'
    page.execute_script("$('#fuel_receipt_date_of_issue').val('2016-10-30')")
    click_button 'Conferma'
  end

  def update_fuel_receipt
    visit '/fuel_receipts/1/edit'
    fill_in 'fuel_receipt[total]', with: '324'
    click_button 'Conferma'
  end
end

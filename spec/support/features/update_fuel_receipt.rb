module Features
  def update_fuel_receipt(fuel_receipt_id)
    visit "/fuel_receipts/#{fuel_receipt_id}/edit"
    fill_in 'fuel_receipt[total]', with: '324'
    click_button 'Conferma'
  end
end

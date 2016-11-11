module Features
  def fill_in_insurance_contract
    fill_in 'insurance[total]', with: '1400'
    click_button 'Conferma'
  end
end

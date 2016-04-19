module Features
  def add_payment
    click_link 'Effettua pagamento'
    fill_in 'payment[paid]', with: 50
    fill_in 'payment[method_of_payment]', with: 'cassa'
    fill_in 'payment[payment_date]', with: '05/04/2015'
    click_button 'Effettua pagamento'
  end
end

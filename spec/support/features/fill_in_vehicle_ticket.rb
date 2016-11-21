module Features
  def fill_in_vehicle_ticket
    fill_in 'ticket_total', with: 90
    page.select 'Veicolo', from: 'ticket[type_of]'
    page.select 'ER354BS', from: 'ticket[vehicle_id]'
    fill_in 'ticket[date_of_issue]', with: Time.zone.now
    fill_in 'ticket[deadline]', with: Time.zone.now + 1.month
    click_button 'Conferma'
  end
end

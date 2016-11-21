module Features
  def fill_in_administrative_ticket
    fill_in 'ticket_total', with: 90
    page.select 'Amministrativa', from: 'ticket[type_of]'
    fill_in 'ticket[date_of_issue]', with: Time.zone.now
    fill_in 'ticket[deadline]', with: Time.zone.now + 1.month
    click_button 'Conferma'
  end
end

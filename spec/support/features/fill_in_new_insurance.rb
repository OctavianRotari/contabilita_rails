module Features
  def fill_in_insurance_contract(at_the_expence_of)
    fill_in 'insurance_total', with: 1100
    page.execute_script("$('#insurance_date_of_issue').val('2016-05-10')")
    page.select 'Trimestrale', from: 'insurance[recurrence]'
    page.select at_the_expence_of, from: 'insurance[vehicle_id]'
    page.select 'Milano assicurazioni', from: 'insurance[company_id]'
    page.execute_script("$('#insurance_deadline').val('2016-05-30')")
    fill_in 'insurance[serial_of_contract]', with: '12321'
    fill_in 'insurance[description]', with: 'Rca'
    click_button 'Conferma'
  end
end

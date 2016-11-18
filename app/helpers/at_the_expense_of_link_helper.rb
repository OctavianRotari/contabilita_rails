module AtTheExpenseOfLinkHelper
  def link_to_at_the_expense_of(record)
    if record.at_the_expense_of == 'specific_vehicle'
      link_to record.vehicle_plate, vehicle_path(record.vehicle_id)
    elsif record.at_the_expense_of == 'general_expenses'
      link_to 'Spese generali', general_expenses_path
    elsif record.at_the_expense_of == 'multiple_vehicles'
      'Piu veicoli'
    elsif record.at_the_expense_of == 'general_insurance'
      'Assicurazione generale'
    elsif record.at_the_expense_of == 'specific_vehicle'
      link_to record.vehicle_plate, vehicle_path(record.vehicle_id)
    end
  end
end

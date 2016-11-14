module AtTheExpenseOfLinkHelper
  def link_to_at_the_expense_of(invoice)
    if invoice.at_the_expense_of == 'specific_vehicle'
      link_to invoice.vehicle_plate, vehicle_path(invoice.vehicle_id)
    elsif invoice.at_the_expense_of == 'general_expenses'
      link_to 'Spese generali', general_expenses_path
    elsif invoice.at_the_expense_of == 'multiple_vehicles'
      'Piu veicoli'
    elsif invoice.at_the_expense_of == 'general_insurance'
      'Assicurazione generale'
    end
  end
end

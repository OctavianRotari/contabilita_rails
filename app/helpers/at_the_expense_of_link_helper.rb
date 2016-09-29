module AtTheExpenseOfLinkHelper
  def link_to_at_the_expense_of(invoice)
    if invoice.at_the_expense_of == 'Veicolo'
      link_to invoice.vehicle.plate, vehicle_path(invoice.vehicle_id)
    elsif invoice.at_the_expense_of == 'Officina'
      link_to invoice.at_the_expense_of, garage_path
    end
  end
end

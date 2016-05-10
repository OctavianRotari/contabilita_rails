module AddToParents
  def add_to_parents(company_id, invoice)
    company_invoice = Company.build invoice, company_id
    vehicle_invoice = Vehicle.build invoice, invoice[:vehicle_id]
    company_invoice
  end
end

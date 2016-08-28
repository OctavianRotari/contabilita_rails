module Features
  def create_passive_record(company_name, plate)
    category
    company = company(company_name)
    vehicle = vehicle(plate)
    create_passive_invoice(company)
  end

  def create_active_record(company_name, plate)
    category
    company = company(company_name)
    vehicle = vehicle(plate)
    create_active_invoice(company)
  end
end

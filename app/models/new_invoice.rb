class NewInvoice

  def new_invoice
    Invoice.new
  end

  def all_companies
    Company.all
  end

  def all_vehicles
    Vehicle.all
  end

  def all_categories_of_company
    CategoryOfCompany.all
  end

  def new_company
    Company.new
  end

  def new_vehicle
    Vehicle.new
  end
end

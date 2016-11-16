class BuildInsurance
  attr_reader :insurance_params

  def initialize(insurance_params)
    @insurance_params = insurance_params
  end

  def build
    insurance_params.merge!(vehicle_id: vehicle_id, category_id: category_id)
  end

  private

  def vehicle_id
    return nil if at_the_expense_of == 'all_vehicles'
    insurance_params[:vehicle_id]
  end

  def category_id
    return nil unless company_id
    Company.find(company_id).category_id
  end

  def company_id
    insurance_params[:company_id]
  end

  def at_the_expense_of
    insurance_params[:at_the_expense_of]
  end
end

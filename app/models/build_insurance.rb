class BuildInsurance
  attr_reader :insurance_params

  def initialize(insurance_params)
    @insurance_params = insurance_params
  end

  def build
    insurance_params.merge!(vehicle_id: vehicle_id)
  end

  private

  def vehicle_id
    if at_the_expense_of == 'all_vehicles'
      nil
    else
      at_the_expense_of
    end
  end

  def at_the_expense_of
    insurance_params[:at_the_expense_of]
  end
end

class BuildInsurance
  attr_reader :insurance_params

  def initialize(insurance_params)
    @insurance_params = insurance_params
  end

  def build
    insurance_params.merge!(at_the_expense_of: at_the_expense_of)
  end

  private

  def at_the_expense_of
    if vehicle_id == 'all_vehicles'
      @insurance_params[:vehicle_id] = nil
      'Tutti i mezzi'
    elsif !vehicle_id.empty?
      'Veicolo'
    end
  end

  def vehicle_id
    insurance_params[:vehicle_id]
  end
end

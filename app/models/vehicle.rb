class Vehicle < ActiveRecord::Base
  belongs_to :user
  has_many :invoices, dependent: :destroy
  has_many :vehicle_field, dependent: :destroy
  has_many :fuel_receipts
  has_many :insurances
  validates :plate, presence: { message: 'Inserire targa del veicolo' }
  validates :type_of_vehicle, presence: { message: 'Inserire tipo di veicolo' }

  def calculator
    Calculator.new
  end

  def fuel_receipts_per_company(comapny_id)
    fuel_receipts.where(company_id: comapny_id).sum(:total).round(2)
  end

  def self.charge_general_expences
    where(charge_general_expences: true)
  end

  def self.count_vehicles_general(user_id)
    where(charge_general_expences: true).where(user_id: user_id).count
  end

  def fuel_receipts_month_total
    fuel_receipts.month.sum(:total).round(2)
  end

  def fuel_receipts_year_total
    fuel_receipts.year.sum(:total).round(2)
  end

  def passive_invoices_month_total
    invoices.month_passive.sum(:total).round(2)
  end

  def passive_invoices_year_total
    invoices.year_passive.sum(:total).round(2)
  end

  def total_insurance_month
    return 0 if insurances.active.nil?
    return 0 unless insurances.active
    (insurances.active.total / 12).round(2)
  end

  def total_insurance_year
    return 0 unless insurances.active
    insurances.active.total.round(2)
  end

  def general_insurance_month
    user_id = self.user_id
    return 0 if insurances.general_insurances_total(user_id).zero?
    return 0 unless charge_general_expences
    insurances = insurances.general_insurances_total(user_id) / 12
    general_expences = Vehicle.count_vehicles_general(user_id)
    (insurances / general_expences).round(2)
  end

  def general_insurance_year
    user_id = self.user_id
    return 0 unless charge_general_expences
    insurance = insurances.general_insurances_total(user_id)
    general_expences = Vehicle.count_vehicles_general(user_id)
    (insurance / general_expences).round(2)
  end

  def general_expenses_month
    user_id = self.user_id
    return 0 unless charge_general_expences
    general_invoice_total = Invoice.month_general_expences(user_id).sum(:total)
    general_expences = Vehicle.count_vehicles_general(user_id)
    (general_invoice_total / general_expences).round(2)
  end

  def general_expenses_year
    user_id = self.user_id
    return 0 unless charge_general_expences
    general_invoice_total = Invoice.year_general_expences(user_id).sum(:total)
    general_expences = Vehicle.count_vehicles_general(user_id)
    (general_invoice_total / general_expences).round(2)
  end

  def vehicle_field_month
    return 0 unless vehicle_field
    vehicle_field.month.round(2)
  end

  def vehicle_field_year
    return 0 unless vehicle_field
    vehicle_field.year.round(2)
  end

  def current_month_costs
    fuel_receipts_month_total +
      passive_invoices_month_total +
      total_insurance_month +
      general_expenses_month +
      general_insurance_month +
      vehicle_field_month
  end

  def current_year_costs
    fuel_receipts_year_total +
      passive_invoices_year_total +
      total_insurance_year +
      general_expenses_year +
      general_insurance_year +
      vehicle_field_year
  end
end

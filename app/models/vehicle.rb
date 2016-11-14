class Vehicle < ActiveRecord::Base
  belongs_to :user
  has_many :invoices, dependent: :destroy
  has_many :vehicle_field, dependent: :destroy
  has_many :fuel_receipts
  has_one :insurance
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

  def self.general_expences_count
    charge_general_expences.count
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
    return 0 unless self.insurance
    insurance.total / 12
  end

  def total_insurance_year
    return 0 unless self.insurance
    insurance.total
  end

  def general_expenses_month
    return 0 unless self.charge_general_expences
    Invoice.month_general_expences.sum(:total) / Vehicle.general_expences
  end

  def general_expenses_year
    return 0 unless self.charge_general_expences
    Invoice.year_general_expences.sum(:total)
  end

  def current_month_costs
    fuel_receipts_month_total + passive_invoices_month_total + total_insurance_month + general_expenses_month
  end

  def current_year_costs
    fuel_receipts_year_total + passive_invoices_year_total + total_insurance_year + general_expenses_year
  end

  def self.general_expences
    charge_general_expences.count
  end
end

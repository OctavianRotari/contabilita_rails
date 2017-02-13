class Vehicle < ActiveRecord::Base
  belongs_to :user
  has_many :invoices, dependent: :destroy
  has_many :vehicle_field, dependent: :destroy
  has_many :fuel_receipts, dependent: :destroy
  has_many :insurances, dependent: :destroy
  has_many :tickets, dependent: :destroy
  validates :plate, presence: { message: 'Inserire targa del veicolo' }
  validates :type_of_vehicle, presence: { message: 'Inserire tipo di veicolo' }

  def calculator
    Calculator.new
  end

  def fuel_receipts_per_company(comapny_id)
    fuel_receipts.where(company_id: comapny_id).sum(:total).round(2)
  end

  def self.charge_general_expenses
    where(charge_general_expenses: true)
  end

  def self.count_vehicles_general(user_id)
    where(charge_general_expenses: true).where(user_id: user_id).count
  end

  def fuel_receipts_month_total(month = time_now)
    fuel_receipts.total_month(month)
  end

  def fuel_receipts_year_total
    fuel_receipts.total_year
  end

  def passive_invoices_month_total(month = time_now)
    invoices.month_passive_total(month)
  end

  def passive_invoices_year_total
    invoices.year_passive_total
  end

  def total_insurance_month(month = time_now)
    active_insurances = insurances.active
    return 0 unless active_insurances && month.month >= active_insurances.date_of_issue.month
    (active_insurances.total / 12).round(2)
  end

  def insurances_total(month)
    general_insurance_month + total_insurance_month(month)
  end

  def total_insurance_year
    return 0 unless insurances.active
    insurances.active.total.round(2)
  end

  def general_insurance_month
    user_id = self.user_id
    general_insurances = Insurance.general_insurances_total(user_id) / 12
    return 0 if general_insurances.zero?
    general_expenses = Vehicle.count_vehicles_general(user_id)
    (general_insurances / general_expenses).round(2)
  end

  def general_insurance_year
    user_id = self.user_id
    general_insurances = Insurance.general_insurances_total(user_id)
    return 0 if general_insurances.zero?
    general_expences = Vehicle.count_vehicles_general(user_id)
    (general_insurances / general_expences).round(2)
  end

  def general_expenses_month(month = time_now)
    user_id = self.user_id
    general_invoices_total = Invoice.month_general_expenses_total(user_id, month)
    return 0 if general_invoices_total.zero?
    general_expenses = Vehicle.count_vehicles_general(user_id)
    (general_invoices_total / general_expenses).round(2)
  end

  def general_expenses_year
    user_id = self.user_id
    general_invoices_total = Invoice.year_general_expenses_total(user_id)
    return 0 if general_invoices_total.zero?
    general_expenses = Vehicle.count_vehicles_general(user_id)
    (general_invoices_total / general_expenses).round(2)
  end

  def vehicle_field_month(month = time_now)
    return 0 unless vehicle_field
    vehicle_field.month(month).round(2)
  end

  def vehicle_field_year
    return 0 unless vehicle_field
    vehicle_field.year.round(2)
  end

  def total_tickets_month(month = time_now)
    tickets.total_vehicles_month(month)
  end

  def total_tickets_year
    tickets.total_vehicles_year
  end

  def total_administrative_tickets_month(month = time_now)
    user_id = self.user_id
    administrative_tickets_total = Ticket.total_administrative_month(user_id, month)
    return 0 if administrative_tickets_total.zero?
    general_expenses = Vehicle.count_vehicles_general(user_id)
    (administrative_tickets_total / general_expenses).round(2)
  end

  def total_administrative_tickets_year
    user_id = self.user_id
    administrative_tickets_total = Ticket.total_administrative_year(user_id)
    return 0 if administrative_tickets_total.zero?
    general_expenses = Vehicle.count_vehicles_general(user_id)
    (administrative_tickets_total / general_expenses).round(2)
  end

  def specific_month_costs(month = time_now)
    fuel_receipts_month_total(month) +
      passive_invoices_month_total(month) +
      total_insurance_month(month) +
      vehicle_field_month(month) +
      total_tickets_month(month)
  end

  def general_month_costs(month = time_now)
    return 0 unless charge_general_expenses
    general_expenses_month(month) +
      general_insurance_month +
      total_administrative_tickets_month(month)
  end

  def current_month_costs(month = time_now)
    specific_month_costs(month) + general_month_costs(month)
  end

  def specific_year_costs
    fuel_receipts_year_total +
      passive_invoices_year_total +
      total_insurance_year +
      vehicle_field_year +
      total_tickets_year
  end

  def general_year_costs
    return 0 unless charge_general_expenses
    general_expenses_year +
      general_insurance_year +
      total_administrative_tickets_year
  end

  def current_year_costs
    specific_year_costs + general_year_costs
  end

  def time_now
    Time.zone.now
  end
end

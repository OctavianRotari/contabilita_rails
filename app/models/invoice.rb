class Invoice < ActiveRecord::Base
  belongs_to :user
  has_many :payments, dependent: :destroy
  has_many :taxable_vat_fields, dependent: :destroy
  has_many :vehicle_field, dependent: :destroy
  belongs_to :company
  belongs_to :vehicle
  belongs_to :category
  accepts_nested_attributes_for :taxable_vat_fields, allow_destroy: true
  accepts_nested_attributes_for :vehicle_field, allow_destroy: true

  validates :type_of_invoice, presence: {message: "Selezionare il tipo di fattura"}
  validates :company_id, presence: {message: "Selezionare l'azienda la quale ha emesso o ricevuto la fattura"}
  validates :at_the_expense_of, presence: {message: "Selezionare a carrico di cosa e registrata la fattura"}
  validates :reason, presence: {message: "Inserire il motivo della fattura"}
  validates :date_of_issue, presence: {message: "Selezionare data di emissione"}
  validates :deadline, presence: {message: "Selezionare data di scadenza"}

  def self.payments(params_id)
    find(params_id).payments
  end

  def self.active
    where(type_of_invoice: 'attiva').order(created_at: :desc)
  end

  def self.passive
    where(type_of_invoice: 'passiva').order(created_at: :desc)
  end

  def company_name
    company.name
  end

  def vehicle_plate
    vehicle.plate
  end

  def self.month_passive(month = time_now)
    passive.where('date_of_issue >= ? and date_of_issue <= ?', month.beginning_of_month, month.end_of_month)
  end

  def self.month_active(month = time_now)
    active.where('date_of_issue >= ? and date_of_issue <= ?', month.beginning_of_month, month.end_of_month)
  end

  def self.year_passive(year = time_now)
    passive.where('date_of_issue >= ? and date_of_issue <= ?', year.beginning_of_year, year.end_of_year)
  end

  def self.year_active(year = time_now)
    active.where('date_of_issue >= ? and date_of_issue <= ?', year.beginning_of_year, year.end_of_year)
  end

  def self.month_general_expenses(user_id)
    month_passive.where(at_the_expense_of: 'general_expenses').where(user_id: user_id)
  end

  def self.year_general_expenses(user_id)
    year_passive.where(at_the_expense_of: 'general_expenses').where(user_id: user_id)
  end

  def self.month_passive_total
    month_passive.sum(:total).round(2)
  end

  def self.year_passive_total
    year_passive.sum(:total).round(2)
  end

  def self.not_paid
    passive.where(paid: false)
  end

  def self.not_collected
    active.where(paid: false)
  end

  def self.total_all
    sum(:total).round(2)
  end

  def self.total_vat_all
    sum(:total_vat).round(2)
  end

  def total_payments
    payments.sum(:paid).to_i
  end

  private_class_method

  def self.order_by_year(params)
    where('extract(year from date_of_issue) = ?', params[:year_param] )
  end

  def self.time_now
    Time.zone.now
  end
end

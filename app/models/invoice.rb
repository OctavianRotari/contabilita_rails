class Invoice < ActiveRecord::Base
  belongs_to :user
  has_many :payments, dependent: :destroy
  has_many :taxable_vat_fields, dependent: :destroy
  belongs_to :company
  belongs_to :vehicle
  belongs_to :category
  accepts_nested_attributes_for :taxable_vat_fields, allow_destroy: true

  validates :type_of_invoice, presence: {message: "Selezionare il tipo di fattura"}
  validates :company_id, presence: {message: "Selezionare l'azienda la quale ha emesso o ricevuto la fattura"}
  validates :at_the_expense_of, presence: {message: "Selezionare a carrico di cosa e registrata la fattura"}
  validates :reason, presence: {message: "Inserire il motivo della fattura"}
  validates :date_of_issue, presence: {message: "Selezionare data di emissione"}
  validates :deadline, presence: {message: "Selezionare data di scadenza"}

  def self.payments(params_id)
    find(params_id).payments
  end

  def self.active_by_year_and_month(params)
    active_ord_by_year(params).group_by { |t| t.date_of_issue.beginning_of_month }
  end

  def self.passive_by_year_and_month(params)
    passive_ord_by_year(params).group_by { |t| t.date_of_issue.beginning_of_month }
  end

  def self.active_ord_by_year(params)
    order_by_year(params).active
  end

  def self.passive_ord_by_year(params)
    order_by_year(params).passive
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

  def self.current_month_passive_invoices
    passive.where('extract(month from date_of_issue) = ?', time_now.month)
  end

  def self.current_year_passive_invoices
    passive.where('extract(year  from date_of_issue) = ?', time_now.year)
  end

  def self.not_paid
    passive.where(paid: false)
  end

  def self.not_collected
    active.where(paid: false)
  end

  def total_payments
    payments.sum(:paid).to_i
  end

  private

  def self.order_by_year(params)
    where("extract(year from date_of_issue) = ?", params[:year_param] )
  end

  def self.time_now
    Time.zone.now
  end
end

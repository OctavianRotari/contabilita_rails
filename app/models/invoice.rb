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

  def self.payments params_id
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
    passive.where('date_of_issue >= ? and created_at <= ?', Time.now.beginning_of_month, Time.now.end_of_month )
  end

  def self.current_year_passive_invoices
    passive.where('date_of_issue >= ? and created_at <= ?', Time.now.beginning_of_year, Time.now.end_of_year )
  end

  def self.not_paid
    passive.collect do |invoice|
      if invoice.total != total_payments(invoice.id)
        invoice
      end
    end.compact
  end

  def self.not_collected
    active.collect do |invoice|
      if invoice.total != total_payments(invoice.id)
        invoice
      end
    end.compact
  end

  private

  def self.order_by_year(params)
    where("extract(year from date_of_issue) = ?", params[:year_param] )
  end

  def self.total_payments(invoice_id)
    total_payments = 0
    payments(invoice_id).each do |payment|
      total_payments = payment.paid
    end
    total_payments
  end

end

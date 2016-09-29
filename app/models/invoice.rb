class Invoice < ActiveRecord::Base
  has_many :payments, dependent: :destroy
  has_many :taxable_vat_fields, dependent: :destroy
  belongs_to :company
  belongs_to :vehicle
  belongs_to :category
  accepts_nested_attributes_for :taxable_vat_fields, allow_destroy: true

  validates :date_of_issue, presence: {message: "Selezionare data di emissione"}
  validates :deadline, presence: {message: "Selezionare data di scadenza"}
  validates :company_id, presence: {message: "Selezionare azienda la quale ha emesso o ricevuto la fattura"}
  validates :reason, presence: {message: "Selezionare il motivo della fattura"}
  validates :type_of_invoice, presence: {message: "Selezionare il tipo di fattura"}
  validates :at_the_expense_of, presence: {message: "Selezionare a carrico di cosa e registrata la fattura"}

  def self.payments params_id
    find(params_id).payments
  end

  def self.active_ord_by_year(params)
    order_by_year(params).active
  end

  def self.passive_ord_by_year(params)
    order_by_year(params).passive
  end

  def self.active
    where(type_of_invoice: 'attiva')
  end

  def self.passive
    where(type_of_invoice: 'passiva')
  end

  def company_name
    company.name
  end

  def self.current_month_passive_invoices
    passive.where('date_of_issue >= ? and created_at <= ?', Time.now.beginning_of_month, Time.now.end_of_month )
  end

  def self.current_year_passive_invoices
    passive.where('date_of_issue >= ? and created_at <= ?', Time.now.beginning_of_year, Time.now.end_of_year )
  end

  def self.not_paid
    not_paid_invoices = []
    passive.each do |invoice|
      if invoice.total != total_payments(invoice.id)
        not_paid_invoices.push(invoice)
      end
    end
    not_paid_invoices
  end

  def self.not_collected
    not_collected_invoices = []
    active.each do |invoice|
      if invoice.total != total_payments(invoice.id)
        not_collected_invoices.push(invoice)
      end
    end
    not_collected_invoices
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

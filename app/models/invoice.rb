class Invoice < ActiveRecord::Base
  has_many :payments, dependent: :destroy
  has_many :taxable_vat_fields
  belongs_to :company
  belongs_to :vehicle
  accepts_nested_attributes_for :taxable_vat_fields, allow_destroy: true

  validates :date_of_issue, presence: {message: "Selezionare data di emissione"}
  validates :deadline, presence: {message: "Selezionare data di scadenza"}
  validates :company_id, presence: {message: "Selezionare azienda la quale ha emesso o ricevuto la fattura"}
  validates :reason, presence: {message: "Selezionare il motivo della fattura"}
  validates :vehicle_id, presence: {message: "Selezionare il veicolo a su cui e stata registrata la fattura"}
  validates :type_of_invoice, presence: {message: "Selezionare il tipo di fattura"}

  def self.payments params_id
    find(params_id).payments
  end

  def self.active_ord_by_year(params)
    order_by_year(params).where(type_of_invoice: 'attiva')
  end

  def self.passive_ord_by_year(params)
    order_by_year(params).where(type_of_invoice: 'passiva')
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

  private

  def self.order_by_year(params)
    where("cast(strftime('%Y', date_of_issue) as int) = ?", params[:year_param] )
  end

end

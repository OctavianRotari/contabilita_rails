class Invoice < ActiveRecord::Base
  has_many :payments, dependent: :destroy
  has_many :taxable_vat_fields
  belongs_to :company
  belongs_to :vehicle
  accepts_nested_attributes_for :taxable_vat_fields, allow_destroy: true

  validates_presence_of :date_of_issue,
                        :deadline,
                        :company_id,
                        :total_vat,
                        :total,
                        :reason,
                        :total_taxable,
                        :vehicle_id,
                        :type_of_invoice

  def self.payments params_id
    find(params_id).payments
  end

  def self.active_ord_by_year(params)
    order_by_year(params).where(type_of_invoice: 'attiva')
  end

  def self.passive_ord_by_year(params)
    order_by_year(params).where(type_of_invoice: 'passiva')
  end

  def company_name
    company.name
  end

  private

  def self.order_by_year(params)
    where("cast(strftime('%Y', date_of_issue) as int) = ?", params[:year_param] )
  end

end

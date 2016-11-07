class Vehicle < ActiveRecord::Base
  belongs_to :user
  has_many :invoices, dependent: :destroy
  has_many :fuel_receipts
  validates :plate, presence: { message: 'Inserire targa del veicolo' }
  validates :type_of_vehicle, presence: { message: 'Inserire tipo di veicolo' }

  def calculator
    Calculator.new
  end

  def fuel_receipts_per_company(comapny_id)
    fuel_receipts.where(company_id: comapny_id)
  end

  def self.charge_general_expences
    where(charge_general_expences: true)
  end
end

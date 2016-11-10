class Category < ActiveRecord::Base
  belongs_to :user
  has_many :invoices, dependent: :destroy
  has_many :companies, dependent: :destroy
  validates :name, presence: { message: 'Inserire il nome della categoria' }
  has_many :fuel_receipts

  def calculator
    Calculator.new
  end

  def self.gas_station_id
    gas_station.id if gas_station
  end

  def self.gas_station
    find_by(type_of: 'Benzinaii')
  end

  def self.insurance_id
    insurance.id if insurance
  end

  def self.insurance
    find_by(type_of: 'Assicurazioni')
  end
end

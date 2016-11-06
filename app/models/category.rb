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
    gas_station == nil ?  nil : gas_station.id
  end

  def self.gas_station
    find_by(gas_station: true)
  end
end

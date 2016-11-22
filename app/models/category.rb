class Category < ActiveRecord::Base
  belongs_to :user
  has_many :invoices, dependent: :destroy
  has_many :insurances, dependent: :destroy
  has_many :companies, dependent: :destroy
  validates :name, presence: { message: 'Inserire il nome della categoria' }
  validates :type_of, presence: { message: 'Selezionare tipologia' }

  def calculator
    Calculator.new
  end

  def self.gas_station_id
    gas_station.id if gas_station
  end

  def self.gas_station
    find_by(type_of: 2)
  end

  def self.insurance_id
    insurance.id if insurance
  end

  def insurance?
    return true if self.type_of == 3
    false
  end

  def self.insurance
    find_by(type_of: 3)
  end
end

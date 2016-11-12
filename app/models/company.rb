class Company < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :invoices, dependent: :destroy
  has_many :fuel_receipts
  has_many :insurances

  phony_normalize :number, default_country_code: 'IT'
  validates :name, presence: { message: "Inserire nome dell'azienda" }
  validates :adress, presence: { message: "Inserire indirizzo dell'azienda" }
  validates :number, presence: { message: "Inserire numero telefonico dell'azienda" }
  validates :category_id, presence: { message: "Selezionare categoria dell'azienda" }

  def vehicles_insured
    Vehicle.joins(insurance: :company)
  end

  def vehicles_refueling
    Vehicle.joins(fuel_receipts: :company)
  end

  def calculator
    Calculator.new
  end

  def self.gas_stations
    where(category_id: Category.gas_station_id)
  end

  def self.insurances
    where(category_id: Category.insurance_id)
  end

  def insurance?
    true if category.type_of == 3
  end

  def category_name
    category.name
  end
end

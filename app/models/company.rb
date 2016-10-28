class Company < ActiveRecord::Base
  belongs_to :user
  has_many :invoices, dependent: :destroy
  has_many :fuel_receipts

  belongs_to :category

  phony_normalize :number, default_country_code: 'IT'
  validates :name, presence: {message: "Inserire nome dell'azienda"}
  validates :adress, presence: {message: "Inserire indirizzo dell'azienda"}
  validates :number, presence: {message: "Inserire numero telefonico dell'azienda"}
  validates :category_id, presence: {message: "Selezionare categoria dell'azienda"}

  def calculator
    Calculator.new
  end

  def self.gas_stations
    where(category_id: Category.gas_station_id)
  end

  def category_name
    category.category
  end

end

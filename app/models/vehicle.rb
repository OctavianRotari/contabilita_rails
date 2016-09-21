class Vehicle < ActiveRecord::Base
  has_many :invoices, dependent: :destroy
  validates :plate, presence: {message: "Inserire targa del veicolo"}
  validates :type_of_vehicle, presence: {message: "Selezionare tipo di veicolo"}

  validates :plate, uniqueness: {message: "Veicolo con questa targa gia registrata"}

  def passive_invoices
    invoices.passive
  end

  def active_invoices
    invoices.active
  end
end

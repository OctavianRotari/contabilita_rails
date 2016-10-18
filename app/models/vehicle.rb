class Vehicle < ActiveRecord::Base
  belongs_to :user
  has_many :invoices, dependent: :destroy
  validates :plate, presence: {message: "Inserire targa del veicolo"}
  validates :type_of_vehicle, presence: {message: "Inserire tipo di veicolo"}

  def passive_invoices(id)
    invoices.where(vehicle_id: id).passive
  end

  def active_invoices(id)
    invoices.where(vehicle_id: id).active
  end
end

class Vehicle < ActiveRecord::Base
  has_many :invoices, dependent: :destroy

  def self.invoices params_id
    find(params_id).invoices
  end

  def self.build invoice, vehicle_id
    vehicle = self.invoices(vehicle_id)
    vehicle.build(invoice)
  end
end

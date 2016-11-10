class Insurance < ActiveRecord::Base
  belongs_to :user
  belongs_to :vehicle
  belongs_to :company
  has_many :receipts, dependent: :destroy

  def company_name
    company.name
  end

  def vehicle_plate
    vehicle.plate
  end
end

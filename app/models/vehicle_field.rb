class VehicleField < ActiveRecord::Base
  belongs_to :invoice
  belongs_to :vehicles
end

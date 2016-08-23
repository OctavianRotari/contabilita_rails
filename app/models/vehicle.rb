class Vehicle < ActiveRecord::Base
  has_many :invoices, dependent: :destroy
  validates :plate, presence: true
  validates :type_of_vehicle, presence: true

  def self.invoices params_id
    find(params_id).invoices
  end

end

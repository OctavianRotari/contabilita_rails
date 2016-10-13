class Vehicle < ActiveRecord::Base
  belongs_to :user
  has_many :invoices, dependent: :destroy
  validates :plate, presence: true
  validates :type_of_vehicle, presence: true

  def passive_invoices
    invoices.passive
  end

  def active_invoices
    invoices.active
  end
end

class Payment < ActiveRecord::Base
  belongs_to :user
  belongs_to :invoice
  validates :paid, presence:true
  validates :method_of_payment, presence:true
  validates :payment_date, presence:true
end

class FuelReceipt < ActiveRecord::Base
  belongs_to :companies
  belongs_to :categories
  belongs_to :users
  belongs_to :vehicle

end

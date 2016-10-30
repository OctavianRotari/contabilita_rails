class FuelReceipt < ActiveRecord::Base
  belongs_to :company
  belongs_to :category
  belongs_to :user
  belongs_to :vehicle

  def self.company(company_id)
    where(company_id: company_id)
  end
end

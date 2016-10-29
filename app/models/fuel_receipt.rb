class FuelReceipt < ActiveRecord::Base
  belongs_to :companies
  belongs_to :categories
  belongs_to :users
  belongs_to :vehicle

  def self.company(company_id)
    where(company_id: company_id)
  end

  def company_name(id)
    Company.find(id).name
  end
end

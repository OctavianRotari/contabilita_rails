class FuelReceipt < ActiveRecord::Base
  belongs_to :company
  belongs_to :category
  belongs_to :user
  belongs_to :vehicle

  def self.company(company_id)
    where(company_id: company_id)
  end

  def self.current_month
    where('date_of_issue >= ? and created_at <= ?', Time.now.beginning_of_month, Time.now.end_of_month )
  end

  def self.current_year
    where('date_of_issue >= ? and created_at <= ?', Time.now.beginning_of_year, Time.now.end_of_year )
  end
end

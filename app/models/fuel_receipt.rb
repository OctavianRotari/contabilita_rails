class FuelReceipt < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  belongs_to :vehicle
  belongs_to :company

  validates :total, presence: { message: 'Inserire il totale dello scontrino' }
  validates :litres, presence: { message: 'Inserire i litri' }
  validates :company_id, presence: { message: 'Selezionare azienda' }
  validates :vehicle_id, presence: { message: 'Selezionare mezzo' }
  validates :date_of_issue, presence: { message: 'Selezionare data di emissione' }

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

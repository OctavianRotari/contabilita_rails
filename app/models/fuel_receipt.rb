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

  def self.month(month = time_now)
    where('date_of_issue >= ? and date_of_issue <= ?', month.beginning_of_month, month.end_of_month )
  end

  def self.year(year = time_now)
    where('date_of_issue >= ? and date_of_issue <= ?', year.beginning_of_year, year.end_of_year )
  end

  def self.total_all
    sum(:total).round(2)
  end

  private

  def self.time_now
    Time.now
  end
end

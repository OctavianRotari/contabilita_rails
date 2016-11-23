class Ticket < ActiveRecord::Base
  belongs_to :vehicle

  validates :total, presence: { message: 'Inserire il totale della multa' }
  validates :type_of, presence: { message: 'Selezionare il tipo di multa' }
  validates :description, presence: { message: 'Inserire una descrizione della multa' }
  validates :date_of_issue, presence: { message: 'Selezionare data di emissione' }
  validates :deadline, presence: { message: 'Selezionare data di scadenza' }

  def self.month(month = time_now)
    where('date_of_issue >= ? and date_of_issue <= ?', month.beginning_of_month, month.end_of_month)
  end

  def self.year(year = time_now)
    where('date_of_issue >= ? and date_of_issue <= ?', year.beginning_of_year, year.end_of_year)
  end

  def self.administrative
    where(type_of: 2)
  end

  def self.vehicle
    where(type_of: 1)
  end

  def self.administrative_current_user(user_id)
    administrative.where(user_id: user_id)
  end

  def self.time_now
    Time.zone.now
  end

  def self.total_vehicles_month
    vehicle.month.sum(:total)
  end

  def self.total_vehicles_year
    vehicle.year.sum(:total)
  end

  def self.total_administrative_month(user_id)
    administrative_current_user(user_id).month.sum(:total)
  end

  def self.total_administrative_year(user_id)
    administrative_current_user(user_id).year.sum(:total)
  end
end

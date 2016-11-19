class Ticket < ActiveRecord::Base
  belongs_to :vehicle

  def self.month(month = time_now)
    where('date_of_issue >= ? and date_of_issue <= ?', month.beginning_of_month, month.end_of_month)
  end

  def self.year(year = time_now)
    where('date_of_issue >= ? and date_of_issue <= ?', year.beginning_of_year, year.end_of_year)
  end

  def self.administrative(user_id)
    where(type_of: 2).where(user_id: user_id)
  end

  def self.time_now
    Time.zone.now
  end
end

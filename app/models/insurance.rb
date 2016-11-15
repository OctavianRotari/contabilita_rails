class Insurance < ActiveRecord::Base
  belongs_to :user
  belongs_to :vehicle
  belongs_to :company
  has_many :receipts, dependent: :destroy

  def payment_date
    due_date = self.date_of_issue
    until due_date > Time.zone.now do
      self.recurrence == 12 ? due_date += 1.year : due_date += self.recurrence.months
    end
    due_date.strftime('%d-%m-%Y')
  end

  def self.month(month = time_now)
    where('date_of_issue >= ? and date_of_issue <= ?', month.beginning_of_month, month.end_of_month)
  end

  def self.year(year = time_now)
    year = year.to_i
    year = Date.new(year)
    where('date_of_issue >= ? and date_of_issue <= ?', year.beginning_of_year, year.end_of_year)
  end

  def company_name
    company.name
  end

  def vehicle_plate
    vehicle.plate
  end

  def self.total_all
    sum(:total).round(2)
  end

  def total_receipts
    receipts.sum(:paid).round(2)
  end

  def self.active
    find_by('date_of_issue <= ? and deadline >= ?', time_now, time_now)
  end

  def self.general_insurances(user_id)
    where('date_of_issue <= ? and deadline >= ?', time_now, time_now).
      where(at_the_expense_of: 'general_insurance').where(user_id: user_id)
  end

  def self.general_insurances_total(user_id)
    general_insurances(user_id).sum(:total)
  end

  def self.time_now
    Time.zone.now
  end
end

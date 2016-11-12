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

  def self.current_year
    where('extract(year  from date_of_issue) = ?', time_now.year)
  end

  def company_name
    company.name
  end

  def vehicle_plate
    vehicle.plate
  end

  private

  def self.time_now
    Time.zone.now
  end
end

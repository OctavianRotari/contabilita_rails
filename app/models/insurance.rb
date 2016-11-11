class Insurance < ActiveRecord::Base
  belongs_to :user
  belongs_to :vehicle
  belongs_to :company
  has_many :receipts, dependent: :destroy

  def payment_date
    due_date = self.date_of_issue
    until due_date > Time.zone.now do
      due_date += self.recurrence.months
    end
    due_date.strftime("%d-%m-%Y")
  end

  def company_name
    company.name
  end

  def vehicle_plate
    vehicle.plate
  end
end

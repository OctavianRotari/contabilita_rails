class VehicleField < ActiveRecord::Base
  belongs_to :invoice
  belongs_to :vehicles

  def self.month
    where('created_at >= ? and created_at <= ?', time_now.beginning_of_month, time_now.end_of_month).sum(:part_of_total)
  end

  def self.year
    where('created_at >= ? and created_at <= ?', time_now.beginning_of_year, time_now.end_of_year).sum(:part_of_total)
  end

  def self.time_now
    Time.zone.now
  end
end

class Category < ActiveRecord::Base
  belongs_to :user
  has_many :invoices, dependent: :destroy
  has_many :companies, dependent: :destroy
  validates :category, presence: {message: "Inserire il nome della categoria"}

  def self.invoices(category_id)
    find(category_id).invoices
  end

  def passive_invoices(id)
    invoices.where(category_id: id).passive
  end

  def active_invoices(id)
    invoices.where(category_id: id).active
  end

  def calculator
    Calculator.new
  end

end

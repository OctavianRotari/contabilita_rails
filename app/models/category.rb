class Category < ActiveRecord::Base
  belongs_to :user
  has_many :invoices, dependent: :destroy
  has_many :companies, dependent: :destroy
  validates :category, presence:true

  def self.invoices(category_id)
    find(category_id).invoices
  end

  def passive_invoices
    invoices.passive
  end

  def active_invoices
    invoices.active
  end

end

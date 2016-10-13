class Company < ActiveRecord::Base
  belongs_to :user
  has_many :invoices, dependent: :destroy

  belongs_to :category

  validates :name, presence:true
  validates :number, presence:true
  validates :adress, presence:true

  validates :category_id, presence:true

  def self.invoices params_id
    find(params_id).invoices
  end

  def passive_invoices
    invoices.passive
  end

  def active_invoices
    invoices.active
  end
end

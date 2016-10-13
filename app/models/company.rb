class Company < ActiveRecord::Base
  belongs_to :user
  has_many :invoices, dependent: :destroy

  belongs_to :category

  validates :name, presence:true
  phony_normalize :number, default_country_code: 'IT'
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

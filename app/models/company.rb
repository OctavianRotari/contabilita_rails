class Company < ActiveRecord::Base
  has_many :invoices, dependent: :destroy
  belongs_to :category_of_company

  def self.invoices params_id
    find(params_id).invoices
  end

end

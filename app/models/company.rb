class Company < ActiveRecord::Base
  has_many :invoices, dependent: :destroy

  def self.invoices params_id
    find(params_id).invoices
  end

end

class Company < ActiveRecord::Base
  has_many :invoices

  def self.invoices params_id
    find(params_id).invoices
  end

end

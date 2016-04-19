class Company < ActiveRecord::Base
  has_many :invoices, dependent: :destroy

  def self.invoices params_id
    find(params_id).invoices
  end

  def self.build invoice, company_id
    company = self.invoices(company_id)
    company.build(invoice)
  end
end

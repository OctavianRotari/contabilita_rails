class Invoice < ActiveRecord::Base
  belongs_to :company

  def self.by_company params_id
    Company.invoices params_id
  end

  def company_name
    company.name
  end

  def company_id
    company.id
  end
end

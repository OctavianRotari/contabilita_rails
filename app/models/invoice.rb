class Invoice < ActiveRecord::Base
  belongs_to :company

  def self.by_company params_id
    Company.invoices params_id
  end

  def self.build_invoice invoice_params, company_id
    company = Company.invoices(company_id)
    company.build(invoice_params)
  end

  def company_name
    company.name
  end

  def company_id
    company.id
  end
end

class Invoice < ActiveRecord::Base
  attr_accessor :taxable
  belongs_to :company

  def self.by_company params_id
    Company.invoices params_id
  end

  def self.build_invoice invoice_params, company_id
    company = Company.invoices(company_id)
    company.build(invoice_params)
  end

  def self.calculate_total invoice_params
    vat = invoice_params[:taxable].to_i * invoice_params[:vat].to_i/100
    invoice_params[:vat] = vat
    invoice_params = invoice_params.merge(total: vat + invoice_params[:taxable].to_i )
    invoice_params
  end

  def company_name
    company.name
  end

  def company_id
    company.id
  end
end

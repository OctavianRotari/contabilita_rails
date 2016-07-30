class CompanyInvoicesDashboard
  
  attr_reader :company_id

  def initialize company_id
    @company_id = company_id
  end

  def company_name
    Company.find(@company_id).name
  end

  def passive_invoices
    Invoice.where(company_id: company_id)
  end

end

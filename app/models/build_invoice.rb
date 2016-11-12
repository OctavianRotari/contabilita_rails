class BuildInvoice
  attr_reader :invoice_params

  def initialize(invoice_params)
    @invoice_params = invoice_params
  end

  def build
    total_vat
    total_taxable
    updated_invoice
  end

  private

  def updated_invoice
    invoice_params.merge!(total: total,
                          vehicle_id: vehicle_id,
                          category_id: category_id)
  end

  def vehicle_id
    if at_the_expense_of == 'general_expences'
      nil
    else
      at_the_expense_of
    end
  end

  def category_id
    return nil if company_id.empty?
    Company.find(company_id).category_id
  end

  def company_id
    invoice_params[:company_id]
  end

  def at_the_expense_of
    invoice_params[:at_the_expense_of]
  end

  def total
    invoice_params[:total_vat] + invoice_params[:total_taxable]
  end

  def total_vat
    Vat.new(invoice_params).total_vat
  end

  def total_taxable
    Taxable.new(invoice_params).total_taxable
  end
end

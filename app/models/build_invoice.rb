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
    invoice_params.merge!(total: total, category_id: category_id, vehicle_id: vehicle_id)
  end

  def vehicle_id
    nil if invoice_params[:at_the_expense_of] == 'multiple_vehicles'
    invoice_params[:vehicle_id] if invoice_params[:at_the_expense_of] == 'specific_vehicle'
  end

  def category_id
    return nil unless company_id
    Company.find(company_id).category_id
  end

  def company_id
    invoice_params[:company_id]
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

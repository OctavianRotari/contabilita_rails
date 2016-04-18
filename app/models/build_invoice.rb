class BuildInvoice

  include CalculateTaxable
  include CalculateVat
  include ClearInvoiceParams

  def initialize(invoice_params)
    @invoice_params = invoice_params
  end

  def build
    @invoice_params = updated_invoice
    clear_invoice(@invoice_params)
    @invoice_params
  end

  private

  def updated_invoice
    @invoice_params.merge(total: total,vat: total_vat(@invoice_params),taxable:total_taxable(@invoice_params))
  end

  def total
    total_vat(@invoice_params) + total_taxable(@invoice_params)
  end

end

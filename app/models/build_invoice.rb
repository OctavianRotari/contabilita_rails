class BuildInvoice

  include CalculateTaxable
  include CalculateVat

  def initialize(invoice_params)
    @invoice_params = invoice_params
    @taxable = []
    @vat = []
    @total_vat = 0
    @total_taxable = 0
  end

  def taxable
    @taxable.push(@invoice_params[:taxable].to_f)
  end

  def vat
    @vat.push(@invoice_params[:vat].to_i)
  end

  def build
    vat
    taxable
    @total_vat = total_vat(@taxable, @vat)
    @total_taxable = total_taxable(@taxable)
    @invoice_params = updated_invoice
    @invoice_params
  end

  private

  def updated_invoice
    @invoice_params.merge(total: total,vat: @total_vat ,taxable: @total_taxable)
  end

  def total
    @total_vat + @total_taxable
  end

end

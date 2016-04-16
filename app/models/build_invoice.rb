require_relative 'calculate_taxable'
require_relative 'calculate_vat'

class BuildInvoice

  def initialize invoice_params
    @invoice_params = invoice_params
    @taxable = CalculateTaxable.new(invoice_params)
    @vat = CalculateVat.new(invoice_params)
  end

  def total
    total_vat = @vat.total_vat
    total_taxable = @taxable.total_taxable
    total =  total_vat + total_taxable
    @invoice_params = @invoice_params.merge(total: total, vat: total_vat)
    clear_invoice_params
    @invoice_params
  end

  private

  def clear_invoice_params
    i = 1
    while i < 4
      vat = 'vat_' + i.to_s
      taxable = 'taxable_' + i.to_s
      clear vat, taxable
      i += 1
    end
  end

  def clear vat, taxable
    @invoice_params.delete(vat.to_sym)
    @invoice_params.delete(taxable.to_sym)
  end

end

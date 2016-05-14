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

  def taxable params
    @taxable.push(params[:taxable].to_f)
  end

  def vat params
    @vat.push(params[:vat].to_i)
  end

  def build
    byebug
    vat @invoice_params
    taxable @invoice_params
    if @invoice_params.has_key?(:taxable_vat_fields_attributes)
      taxable_vat_fields = @invoice_params[:taxable_vat_fields_attributes]
      added_fields = taxable_vat_fields.keys
      added_fields.each do |field|
        byebug
        vat(taxable_vat_fields[field])
        taxable(taxable_vat_fields[field])
      end
    end
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

class BuildInvoice
  attr_reader :invoice_params

  include CalculateTaxable
  include CalculateVat

  def initialize(invoice_params)
    @invoice_params = invoice_params
    @taxable = []
    @vat = []
    @total_vat = 0
    @total_taxable = 0
  end

  def build
    added_fields
    @total_vat = total_vat(@taxable, @vat)
    @total_taxable = total_taxable(@taxable)
    @invoice_params = updated_invoice
    @invoice_params
  end

  private

  def updated_invoice
    @invoice_params.merge(total: total,total_vat: @total_vat ,total_taxable: @total_taxable, at_the_expense_of: at_the_expense_of)
  end

  def at_the_expense_of
    if @invoice_params[:vehicle_id] == "garage"
      @invoice_params[:vehicle_id] = nil
      "Officina"
    else
      "Veicolo"
    end
  end

  def company_id
    @invoice_params[:company_id]
  end

  def total
    @total_vat + @total_taxable
  end

  def taxable params
    @taxable.push(params[:taxable].to_f)
  end

  def vat params
    @vat.push(params[:vat_rate].to_i)
  end

  def added_fields
    if @invoice_params.has_key?(:taxable_vat_fields_attributes)
      taxable_vat_fields = @invoice_params[:taxable_vat_fields_attributes]
      added_fields = taxable_vat_fields.keys
      added_fields.each do |field|
        vat(taxable_vat_fields[field])
        taxable(taxable_vat_fields[field])
      end
    end
  end

end

class Taxable
  include AddToTaxableArray
  include AddedFields

  attr_reader :invoice_params

  def initialize(invoice_params)
    @invoice_params = invoice_params
    @taxables = []
  end

  def total_taxable
    added_fields
    @invoice_params.merge!(total_taxable: calculate_total_taxable)
  end

  private

  def calculate_total_taxable
    total_taxable = 0
    for i in 0..@taxables.length-1
      total_taxable += @taxables[i]
    end
    total_taxable.round(2)
  end

  def add_to(taxable_vat_fields, field)
    add_to_taxable_array(taxable_vat_fields[field])
  end
end

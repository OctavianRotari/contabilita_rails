class Vat
  include AddToTaxableArray
  include AddedFields

  attr_reader :invoice_params, :taxable, :vat

  def initialize(invoice_params)
    @invoice_params = invoice_params
    @taxables = []
    @vats = []
  end

  def total_vat
    added_fields
    @invoice_params.merge!(total_vat: calculate_total_vat)
  end

  private

  def calculate_total_vat
    total_vat = 0
    for i in 0..@vats.length-1
      if @vats[i] == 1
        total_vat += 0
      else
        total_vat += @taxables[i] * @vats[i] / 100
      end
    end
    total_vat.round(2)
  end

  def add_to_vat_array(params)
    @vats.push(params[:vat_rate].to_i)
  end

  def add_to(taxable_vat_fields, field)
    add_to_vat_array(taxable_vat_fields[field])
    add_to_taxable_array(taxable_vat_fields[field])
  end
end

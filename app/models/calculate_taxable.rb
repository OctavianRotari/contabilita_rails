module CalculateTaxable

  def total_taxable params
    i = 1
    taxable_vat_params = params[:taxable_vat_fields_attributes]
    taxable_params = []
    taxable_vat_params.each do |taxable_vat|
      taxable_params.push(taxable_vat[i][:taxable])
      i+=1
    end
    byebug
    total_taxable = 0
    while i < taxable_params.count
      total_taxable += calc_of_taxable(taxable, params)
      i += 1
    end
    total_taxable
  end

  private

  def calc_of_taxable params
    taxable = "taxable"
    total = 0
    if(params.has_key?(taxable.to_sym))
      total += params[taxable.to_sym].to_f
    end
    total
  end
end

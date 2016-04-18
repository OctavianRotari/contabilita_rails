module CalculateTaxable

  def total_taxable params
    i = 1
    total_taxable = 0
    while i < 4
      taxable = 'taxable_' + i.to_s
      total_taxable += calc_of_taxable(taxable, params)
      i += 1
    end
    total_taxable
  end

  private

  def calc_of_taxable taxable, params
    total = 0
    if(params.has_key?(taxable.to_sym))
      total += params[taxable.to_sym].to_f
    end
    total
  end
end

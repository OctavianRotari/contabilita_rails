module CalculateVat

  def total_vat params
    i = 1
    total_vat = 0
    while i < 4
      vat = 'vat_' + i.to_s
      taxable = 'taxable_' + i.to_s
      total_vat += calc_of_vat vat, taxable, params
      i += 1
    end
    total_vat
  end

  private

  def calc_of_vat vat, taxable, params
    total = 0
    if(params.has_key?(vat.to_sym))
      total += params[taxable.to_sym].to_f * params[vat.to_sym].to_i/100
    end
    total
  end

end

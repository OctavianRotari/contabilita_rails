class CalculateVat
  def initialize invoice_params
    @invoice_params = invoice_params
    @total_vat = 0
  end

  def total_vat
    i = 1
    while i < 4
      vat = 'vat_' + i.to_s
      taxable = 'taxable_' + i.to_s
      calc_of_vat vat, taxable
      i += 1
    end
    @total_vat
  end

  def calc_of_vat vat, taxable
    if(@invoice_params.has_key?(vat.to_sym))
      @total_vat += @invoice_params[taxable.to_sym].to_f * @invoice_params[vat.to_sym].to_i/100
    end
  end

end

class CalculateTaxable
  def initialize invoice_params
    @invoice_params = invoice_params
    @total_taxable = 0
  end

  def total_taxable
    i = 1
    while i < 4
      taxable = 'taxable_' + i.to_s
      calc_of_taxable taxable
      i += 1
    end
    @total_taxable
  end

  private

  def calc_of_taxable taxable
    if(@invoice_params.has_key?(taxable.to_sym))
      @total_taxable += @invoice_params[taxable.to_sym].to_f
    end
  end

end

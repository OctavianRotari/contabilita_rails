module ClearInvoiceParams

  def clear_invoice params
    i = 1
    while i < 4
      vat = 'vat_' + i.to_s
      taxable = 'taxable_' + i.to_s
      clear vat, taxable, params
      i += 1
    end
    params
  end

  private

  def clear vat, taxable, params
    params.delete(vat.to_sym)
    params.delete(taxable.to_sym)
  end
end

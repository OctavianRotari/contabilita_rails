class BuildInvoice

  def initialize invoice_params
    @invoice_params = invoice_params
  end

  def total_vat
    total_vat = @invoice_params[:taxable].to_f * @invoice_params[:vat].to_i/100
    @invoice_params.delete(:vat)
    total_vat = check_if_more_vat total_vat
  end

  def check_if_more_vat total_vat
    i = 1
    while i < 3
      vat = 'vat_' + i.to_s
      taxable = 'taxable_' + i.to_s
      if(@invoice_params.has_key?(vat.to_sym))
        total_vat += @invoice_params[taxable.to_sym].to_f * @invoice_params[vat.to_sym].to_i/100
        @invoice_params.delete(vat.to_sym)
      end
      i += 1
    end
    total_vat
  end

  def total_taxable
    total_taxable = @invoice_params[:taxable].to_f
    @invoice_params.delete(:taxable)
    total_taxable = check_if_more_taxable total_taxable
  end

  def check_if_more_taxable total_taxable
    i = 1
    while i < 3
      taxable = 'taxable_' + i.to_s
      if(@invoice_params.has_key?(taxable.to_sym))
        total_taxable += @invoice_params[taxable.to_sym].to_f
        @invoice_params.delete(taxable.to_sym)
      end
      i += 1
    end
    total_taxable
  end

  def total
    total = total_taxable + total_vat
    @invoice_params = @invoice_params.merge(total: total, vat: total_vat)
    @invoice_params
  end
end

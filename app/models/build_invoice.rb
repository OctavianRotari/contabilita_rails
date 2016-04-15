class BuildInvoice
  def initialize invoice_params
    @invoice_params = invoice_params
  end

  def vat
    vat = @invoice_params[:taxable].to_i * @invoice_params[:vat].to_i/100
    if(@invoice_params.has_key?("vat_1"))
      vat_1 = @invoice_params[:taxable_1].to_i * @invoice_params[:vat_1].to_i/100
      vat += vat_1
    end
    if(@invoice_params.has_key?("vat_2"))
      vat_2 = @invoice_params[:taxable_2].to_i * @invoice_params[:vat_2].to_i/100
      vat += vat_2
    end
    @invoice_params[:vat] = vat
    vat
  end

  def total
    total = vat + @invoice_params[:taxable].to_i
    if(@invoice_params.has_key?("taxable_1"))
      total += @invoice_params[:taxable_1].to_i
    end
    if(@invoice_params.has_key?("taxable_2"))
      total += @invoice_params[:taxable_1].to_i
    end
    @invoice_params.merge(total: total )
  end
end

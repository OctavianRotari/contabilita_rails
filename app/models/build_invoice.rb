class BuildInvoice
  def initialize invoice_params
    @invoice_params = invoice_params
  end

  def vat
    vat = @invoice_params[:taxable].to_i * @invoice_params[:vat].to_i/100
    @invoice_params[:vat] = vat
    vat
  end

  def total
    @invoice_params.merge(total: vat + @invoice_params[:taxable].to_i )
  end
end

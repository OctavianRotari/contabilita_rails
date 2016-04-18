class BuildInvoice
  include CalculateTaxable
  include CalculateVat

  def initialize params
    @params = params
    @invoice_params = nil
  end

  def build
    @invoice_params = invoice_params
    update_invoice_params
    Company.build @invoice_params, company_id
  end

  def update_invoice_params
    @invoice_params = @invoice_params.merge(total: total, vat: total_vat(@invoice_params), taxable:total_taxable(@invoice_params))
    clear_invoice_params
    @invoice_params
  end

  private

  def total
    total_vat(@invoice_params) + total_taxable(@invoice_params)
  end

  def company_id
    @params[:company_id]
  end

  def invoice_params
    @params.require(:invoice).permit(:reason,:taxable_1,:vat_1,:taxable_2,:vat_2,:taxable_3,:vat_3,:date_of_issue,:plate,:deadline)
  end

  def clear_invoice_params
    i = 1
    while i < 4
      vat = 'vat_' + i.to_s
      taxable = 'taxable_' + i.to_s
      clear vat, taxable
      i += 1
    end
  end

  def clear vat, taxable
    @invoice_params.delete(vat.to_sym)
    @invoice_params.delete(taxable.to_sym)
  end

end

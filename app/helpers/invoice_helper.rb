module InvoiceHelper
  #def invoice_edit_or_new
    #if invoice_url_include_edit?
      #company_invoice_path(company_id:params[:company_id], invoice_id: @invoice.id) 
    #else
      #company_invoices_path(company_id:params[:company_id], invoice_id: @invoice.id) 
    #end
  #end

  def invoice_url_include_new?
    current_request?(controller: 'invoices', action: 'new')
  end
end

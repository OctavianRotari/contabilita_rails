module InvoiceHelper
  def invoice_edit_or_new
    if request.path_info.include? 'edit'
      company_invoice_path(company_id:params[:company_id], invoice_id: @invoice.id) 
    else
      company_invoices_path(company_id:params[:company_id], invoice_id: @invoice.id) 
    end
  end

  def invoice_url_include_edit?
    request.path_info.include? 'edit' 
  end
end

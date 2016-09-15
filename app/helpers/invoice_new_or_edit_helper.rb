module InvoiceNewOrEditHelper

  def invoice_new_or_edit
    if current_request?(controller: 'invoices', action: 'new')
      @new_invoice.new_invoice
    elsif current_request?(controller: 'invoices', action: 'create')
      @invoice
    else
      @new_invoice.specific_invoice(params)
    end
  end

end

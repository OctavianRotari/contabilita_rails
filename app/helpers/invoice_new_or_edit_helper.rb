module InvoiceNewOrEditHelper
  def invoice_new_or_edit
    current_page?(new_invoice_path) ?  @new_invoice.new_invoice : @new_invoice.specific_invoice(params)
  end
end

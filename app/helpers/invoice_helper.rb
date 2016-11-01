module InvoiceHelper
  def invoice_url_include_new?
    current_request?(controller: 'invoices', action: 'new')
  end
end

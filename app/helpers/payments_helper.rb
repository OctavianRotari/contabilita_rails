module PaymentsHelper
  def payment_edit_or_new
    if request.path_info.include? 'edit'
      invoice_payment_path
    else
      invoice_payments_path
    end
  end
end

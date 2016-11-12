module InvoiceFormHelper
  def association
    if params[:vehicle_id]
      :vehicle_id 
    elsif params[:at_the_expense_of]
      :at_the_expense_of
    end
  end
end

module ListOfTypesOfInvoicesHelper
  def list_of_types_of_invoices_selected_value(form)
    if current_request?(controller: 'invoices', action: 'update')
      form.select(:type_of_invoice, options_for_select([["Attiva", 'attiva'], ["Passiva", 'passiva']], selected: invoice_new_or_edit.type_of_invoice ))
    else
      form.select(:type_of_invoice, options_for_select([["Attiva", 'attiva'], ["Passiva", 'passiva']], prompt: "Tipo di fattura"), {:prompt => "Tipo di fattura"})
    end
  end
end

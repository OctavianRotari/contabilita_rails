module AddedFields
  def added_fields
    if invoice_params.has_key?(:taxable_vat_fields_attributes)
      taxable_vat_fields = invoice_params[:taxable_vat_fields_attributes]
      added_fields = taxable_vat_fields.keys
      added_fields.each do |field|
        add_to(taxable_vat_fields, field)
      end
    end
  end
end

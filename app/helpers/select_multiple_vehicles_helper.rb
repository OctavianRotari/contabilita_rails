module SelectMultipleVehiclesHelper
  def select_multiple_vehicles(invoice, form)
    if invoice.at_the_expense_of == 'multiple_vehicles'
      form.fields_for :vehicle_field do |builder|
        render 'vehicle_field_fields', f: builder
      end
      link_to_add_fields('Aggiungi veicolo', form, :vehicle_field, 'add_vehicle_fields')
    end
  end
end

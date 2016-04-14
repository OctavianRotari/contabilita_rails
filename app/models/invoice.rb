class Invoice < ActiveRecord::Base
  belongs_to :clients_and_supplier

  def issuer_name
    clients_and_supplier.name
  end

  def issuer_id
    clients_and_supplier.id
  end
end

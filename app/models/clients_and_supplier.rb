class ClientsAndSupplier < ActiveRecord::Base
  has_many :invoices
end

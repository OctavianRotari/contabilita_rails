class Invoice < ActiveRecord::Base
  belongs_to :clients_and_supplier
end

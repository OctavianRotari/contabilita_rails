class TaxableVatField < ActiveRecord::Base
  belongs_to :invoice
end

class TaxableVatField < ActiveRecord::Base
  belongs_to :invoice
  validates_presence_of :taxable, :vat_rate
end

class TaxableVatField < ActiveRecord::Base
  belongs_to :invoice
  validates :taxable, presence: {message: "Inserire imponibile"}
end

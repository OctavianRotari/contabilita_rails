class Payment < ActiveRecord::Base
  belongs_to :invoice
  validates :paid, presence: {message: "Inserire l'ammontare pagato o incassato"}
  validates :method_of_payment, presence: {message: "Inserire il metodo di pagamento"}
  validates :payment_date, presence: {message: "Inserire la data del pagamento"}
end

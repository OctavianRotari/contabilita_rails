class Vehicle < ActiveRecord::Base
  has_many :invoices, dependent: :destroy
  validates :plate, presence: {message: "Inserire targa del veicolo"}
  validates :type_of_vehicle, presence: {message: "Selezionare tipo di veicolo"}

  def self.invoices params_id
    find(params_id).invoices
  end

end

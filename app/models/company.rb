class Company < ActiveRecord::Base
  belongs_to :user
  has_many :invoices, dependent: :destroy

  belongs_to :category

  phony_normalize :number, default_country_code: 'IT'
  validates :name, presence: {message: "Inserire nome dell'azienda"}
  validates :adress, presence: {message: "Inserire indirizzo dell'azienda"}
  validates :number, presence: {message: "Inserire numero telefonico dell'azienda"}
  validates :category_id, presence: {message: "Selezionare categoria dell'azienda"}

  def self.invoices params_id
    find(params_id).invoices
  end

  def passive_invoices
    invoices.passive
  end

  def active_invoices
    invoices.active
  end
end

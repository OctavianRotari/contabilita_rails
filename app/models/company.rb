class Company < ActiveRecord::Base
  has_many :invoices, dependent: :destroy

  belongs_to :category

  validates :name, presence: {message: "Inserire nome dell'azienda"}
  validates :number, presence: {message: "Inserire numero telefonico dell'azienda"}
  validates :adress, presence: {message: "Inserire indirizzo dell'azienda"}

  validates :category_id, presence: {message: "Inserire categoria dell'azienda"}
  validates :name, uniqueness: {message: "Azienda con questo nome gia registrata"}

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

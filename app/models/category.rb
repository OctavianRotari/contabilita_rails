class Category < ActiveRecord::Base
  has_many :invoices
  has_many :companies
  validates :category, uniqueness: {message:"Esiste gia una categoria con questo nome"}
  validates :category, presence: {message: "Inserire il nome della categoria"}

  def self.invoices(category_id)
    find(category_id).invoices
  end

end

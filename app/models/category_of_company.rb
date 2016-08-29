class CategoryOfCompany < ActiveRecord::Base
  has_many :companies
  validates :category, uniqueness: {message:"Esiste gia una categoria con questo nome"}
  validates :category, presence: {message: "Inserire il nome della categoria"}

end

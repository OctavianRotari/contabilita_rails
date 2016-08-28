class CategoryOfCompany < ActiveRecord::Base
  has_many :companies
  validates :category, uniqueness: {message:"Esiste gia una categoria con questo nome"}
end

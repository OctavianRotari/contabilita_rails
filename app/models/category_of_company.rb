class CategoryOfCompany < ActiveRecord::Base
  has_many :companies
end

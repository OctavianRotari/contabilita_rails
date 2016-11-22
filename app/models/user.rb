class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :companies, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :payments, dependent: :destroy
  has_many :vehicles, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_many :fuel_receipts, dependent: :destroy
  has_many :insurances, dependent: :destroy
  has_many :tickets, dependent: :destroy
end

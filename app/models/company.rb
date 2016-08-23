class Company < ActiveRecord::Base
  has_many :invoices, dependent: :destroy

  belongs_to :category_of_company

  validates_presence_of :name,
                        :number,
                        :adress

  def self.invoices params_id
    find(params_id).invoices
  end

end

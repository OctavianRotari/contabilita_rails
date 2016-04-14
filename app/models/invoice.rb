class Invoice < ActiveRecord::Base
  belongs_to :company

  def company_name
    company.name
  end

  def company_id
    company.id
  end
end

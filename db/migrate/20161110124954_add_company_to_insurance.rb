class AddCompanyToInsurance < ActiveRecord::Migration
  def change
    add_reference :insurances, :company, index: true, foreign_key: true
  end
end

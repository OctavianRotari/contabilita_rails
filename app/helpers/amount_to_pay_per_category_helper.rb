module AmountToPayPerCategoryHelper

  def passive_amount_to_pay(companies)
    total_passive = 0
    companies.each do |company|
      total_passive += total_remaining_all_invoices(company.invoices.passive)
    end
   total_passive 
  end

  def active_amount_to_collect(companies)
    total_active = 0
    companies.each do |company|
      total_active += total_remaining_all_invoices(company.invoices.active)
    end
    total_active
  end

end

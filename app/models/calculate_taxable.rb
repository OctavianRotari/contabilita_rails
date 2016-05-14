module CalculateTaxable
  def total_taxable(taxables)
    total_taxable = 0
    for i in 0..taxables.length-1
      total_taxable += taxables[i]
    end
    total_taxable
  end
end

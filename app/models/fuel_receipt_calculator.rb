class FuelReceiptCalculator
  def total(fuel_receipts)
    total = 0
    fuel_receipts.each do |fuel_receipt|
      total += fuel_receipt.total
    end
    total
  end
end

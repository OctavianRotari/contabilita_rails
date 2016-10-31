module CalculateVat
  def total_vat(taxables, vats)
    total_vat = 0
    for i in 0..vats.length-1
      total_vat += taxables[i] * vats[i] / 100
    end
    total_vat.round(2)
  end
end

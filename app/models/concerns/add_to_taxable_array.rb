module AddToTaxableArray
  def add_to_taxable_array(params)
    @taxables.push(params[:taxable].to_f)
  end
end

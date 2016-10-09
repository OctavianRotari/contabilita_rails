module CheckIfCategoryExists
  def category_exists?
    if Category.all.empty?
      flash[:error] = "Aggiungere almeno una categoria di aziende"
      false
    else
      true
    end
  end
end

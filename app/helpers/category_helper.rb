module CategoryHelper
  def category(category_id)
    Category.find(category_id).category
  end
end

class ChangeItemsAttributeNutrionixId < ActiveRecord::Migration
  def change
    change_column(:items, :nutritionix_id, :string)
  end
end

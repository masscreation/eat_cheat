class ChangeRecipesAttributeByDroppingString < ActiveRecord::Migration
  def change
    remove_column(:recipes, :string)
  end
end

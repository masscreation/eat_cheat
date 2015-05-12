class ChangeIngredientsAttributes < ActiveRecord::Migration
  def change
    change_column(:ingredients, :quant_of_item_eaten, 'decimal USING CAST(quant_of_item_eaten AS decimal)')
  end
end

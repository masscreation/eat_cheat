class ChangeItemAttributesFromIntegerToDecimalsAndAddNameField < ActiveRecord::Migration
  def change
    change_column(:items, :fat, :decimal)
    change_column(:items, :carbs, :decimal)
    change_column(:items, :protein, :decimal)
    add_column(:items, :name, :string)
  end
end

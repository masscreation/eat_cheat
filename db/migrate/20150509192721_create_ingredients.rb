class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.datetime :time_eaten
      t.string :quant_of_item_eaten
      t.string :integer

      t.timestamps null: false

      t.belongs_to :recipe
      t.belongs_to :item
    end
  end
end

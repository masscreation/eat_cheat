class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :nutritionix_id
      t.integer :calories
      t.integer :fat
      t.integer :protein
      t.integer :carbs
      t.integer :serving_weight_grams

      t.timestamps null: false
    end
  end
end

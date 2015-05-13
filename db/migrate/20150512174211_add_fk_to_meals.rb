class AddFkToMeals < ActiveRecord::Migration
    def change
    add_reference :meals, :item, index: true, foreign_key: true
  	end
end

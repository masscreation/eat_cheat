class CreateMeals < ActiveRecord::Migration
  def change
    create_table :meals do |t|
      t.datetime :time_eaten
      t.belongs_to :recipe
      t.timestamps null: false
    end
  end
end

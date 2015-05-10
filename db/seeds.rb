# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#   id | nutritionix_id | calories | fat | protein | carbs | serving_weight_grams
  
    #creating items and recipes
    pancakes = Recipe.find_or_create_by(name: 'Pancakes')
    stuff = Item.create([{nutritionix_id: '513fceb775b8dbbc21002de8', calories: 455, fat: 1.23, protein: 12.91, carbs: 95.39, serving_weight_grams: 125, name: 'flour' }, {nutritionix_id: '513fceb775b8dbbc21002957', calories: 4.85, fat: 0.02, protein: 0, carbs: 2.35, serving_weight_grams: 125, name: 'Baking Powder - 1 tsp' }, {nutritionix_id: '513fceb775b8dbbc21002957', calories: 4.85, fat: 0.02, protein: 0, carbs: 2.35, serving_weight_grams: 125, name: 'Baking Powder - 1 tsp' }, {nutritionix_id: '513fceb375b8dbbc21000153', calories: 347.49, fat: 23.11, protein: 30.52, carbs: 1.75, serving_weight_grams: 243, name: 'Egg, whole, raw, fresh' }])

    #making association between item and recipe
      pancakes.items = stuff
        #associates the items created above with the recipe created above. this automatically fills in the ingredients (the join table) table's recipe_id and item_id fields. 

      #adding quantity of item eaten, and date eaten to the ingredients table
      ing = Ingredient.where(recipe_id: pancakes.id) 
        #finds the correct join table info, spits it out in an array

      #run through each ing
      ing.each do |x|
        #add time eaten 
        x.update_attribute('time_eaten', '5/9/2015 19:12')

        #sets quantity of item eaten to 1 for everything
        x.update_attribute('quant_of_item_eaten', 1)
      end










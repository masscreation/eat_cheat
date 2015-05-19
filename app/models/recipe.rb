class Recipe < ActiveRecord::Base
  has_many :ingredients, dependent: :destroy
  has_many :items, through: :ingredients
  accepts_nested_attributes_for :ingredients 
  belongs_to :user
  has_many :meals

  	def cal_sum
  		@cal_per_recipe = 0
	    self.items.each do |item|
	    @cal_per_recipe += item.calories.round(1)
	    end
	    @cal_per_recipe
	end

	def carb_sum
		@carb_per_recipe = 0
		self.items.each do |item|
		@carb_per_recipe += item.carbs.round(1)
		end
		@carb_per_recipe
	end

	def prot_sum
		@prot_per_recipe = 0
		self.items.each do |item|
		@prot_per_recipe += item.protein.round(1)
		end
		@prot_per_recipe
	end

	def fat_sum
		@fat_per_recipe = 0
		self.items.each do |item|
		@fat_per_recipe += item.fat.round(1)
		end
		@fat_per_recipe
	end

end

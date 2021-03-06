class Item < ActiveRecord::Base
  has_many :ingredients
  has_many :recipes, through: :ingredients
  has_many :meals
  belongs_to :user
end

class Recipe < ActiveRecord::Base
  has_many :ingredients, dependent: :destroy
  has_many :items, through: :ingredients
  accepts_nested_attributes_for :ingredients
  belongs_to :user
  has_many :meals
end

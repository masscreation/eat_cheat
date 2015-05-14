require 'rails_helper'

RSpec.describe User, :type => :model do

	it "must have a valid email address"  do
	user=User.new
	expect(user.email).to include("@")
	end

	it "must have a valid email address 1"  do
   	expect(user).to_not allow_value("base@example").for(:email)
  	end

	it "must have a valid email address 1"  do
   	expect(user).to_not allow_value("blah").for(:email)
  	end

  	it "should create a new instance of a user given valid attributes" do
    User.create!(@user.attributes)
  	end

	
end



	  
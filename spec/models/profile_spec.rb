require 'rails_helper'

RSpec.describe Profile, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
  describe "The profile" do

	  it "creates a profile"  do
	    profile = build(:profile)
	    expect(profile).to be_instance_of Profile
	  end

	  	it "'s age cannot be a string" do
	  		peter = Profile.new
	  		expect(peter.age).to_not be("Ten")
	  	end

	  	it "'s age is greater than 0" do
	  		peter = Profile.new
	  		if !peter.age == nil
	  		expect(peter.age).to be > 0
	  		end
	  	end


	  	it "'s name can be a name" do
	  		quentin = Profile.new
	  		quentin.name = "Peter"
	  		expect(quentin.name).to_not be("Sandra")

	  	end

		it "A profile must belong to a User" do
	  		quentin = Profile.new
	  		expect(quentin.user_id).to be_truthy
	  	end  
	
end
    

require 'rails_helper'

RSpec.describe Profile, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"

  it "creates a profile"  do
    profile = build(:profile)
    expect(profile).to be_instance_of Profile
  end

end

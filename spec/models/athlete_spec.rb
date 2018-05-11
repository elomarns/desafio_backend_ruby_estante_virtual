require "rails_helper"

RSpec.describe Athlete, type: :model do
  before(:each) do
    @athlete = build(:athlete)
  end

  it "is valid with name" do
    expect(@athlete).to be_valid
  end

  it "is not valid without a name" do
    @athlete.name = nil
    expect(@athlete).to_not be_valid
  end

  it "is not valid without an unique name" do
    @athlete.save
    duplicate_athlete = build(:athlete)
    expect(duplicate_athlete).to_not be_valid
  end
end

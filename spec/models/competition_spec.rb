require "rails_helper"

RSpec.describe Competition, type: :model do
  before(:each) do
    @competition = build(:competition)
  end

  it "is valid with name, unit, finished, results limit per athlete and criterion for best result" do
    expect(@competition).to be_valid
  end

  it "is not finished by default" do
    expect(@competition.finished).to eq(false)
  end

  it "has 1 as results limit per athlete by default" do
    expect(@competition.results_limit_per_athlete).to eq(1)
  end

  it "has max as the criterion for best result by default" do
    expect(@competition.criterion_for_best_result).to eq("max")
  end

  it "is not valid without a name" do
    @competition.name = nil
    expect(@competition).to_not be_valid
  end

  it "is not valid without an unique name" do
    @competition.save
    duplicate_competition = build(:competition)
    expect(duplicate_competition).to_not be_valid
  end

  it "is not valid without an unit" do
    @competition.unit = nil
    expect(@competition).to_not be_valid
  end

  it "is not valid without the results limit per athlete" do
    @competition.results_limit_per_athlete = nil
    expect(@competition).to_not be_valid
  end

  it "is not valid with the results limit per athlete not being a number" do
    @competition.results_limit_per_athlete = "not a number"
    expect(@competition).to_not be_valid
  end

  it "is not valid with the results limit per athlete being a float number" do
    @competition.results_limit_per_athlete = 1.5
    expect(@competition).to_not be_valid
  end

  it "is not valid with the results limit per athlete being a negative integer" do
    @competition.results_limit_per_athlete = -1
    expect(@competition).to_not be_valid
  end

  it "is not valid without the criterion for best result" do
    @competition.criterion_for_best_result = nil
    expect(@competition).to_not be_valid
  end

  it "is not valid with the criterion for best result being anything other than min or max" do
    @competition.criterion_for_best_result = "invalid"
    expect(@competition).to_not be_valid
  end

  it "must finish competition" do
    @competition = build(:competition)
    @competition.finish
    expect(@competition.finished).to eq(true)
  end
end

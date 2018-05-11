require "rails_helper"

RSpec.describe Result, type: :model do
  describe "any result" do
    before(:each) do
      @result = build(:result)
    end

    it "is valid with competition, athlete and value" do
      expect(@result).to be_valid
    end

    it "is not valid without a competition" do
      @result.competition = nil
      expect(@result).to_not be_valid
    end

    it "is not valid when the competition is finished" do
      @result.competition.finished = true
      expect(@result).to_not be_valid
    end

    it "is not valid without an athlete" do
      @result.athlete = nil
      expect(@result).to_not be_valid
    end

    it "is not valid without a value" do
      @result.value = nil
      expect(@result).to_not be_valid
    end

    it "is not valid when value is not a number" do
      @result.value = "not a number"
      expect(@result).to_not be_valid
    end

    it "is not valid when value is a negative number" do
      @result.value = -1
      expect(@result).to_not be_valid
    end
  end

  describe "result from competition with only 1 result per athlete" do
    before(:each) do
      @result = build(:result)
    end

    it "is not valid if the athlete has reached the limit on competition" do
      @result.save
      new_result = Result.new(competition: @result.competition,
                              athlete: @result.athlete,
                              value: 9.7)
      expect(new_result).to_not be_valid
    end
  end

  describe "result from competition with multiple results per athlete" do
    before(:each) do
      @result = build(:result_from_competition_with_multiple_results_per_athlete)
    end

    it "is valid if the athlete has't reached the limit on competition" do
      @result.save
      new_result = Result.new(competition: @result.competition,
                              athlete: @result.athlete,
                              value: 89.3)

      expect(new_result).to be_valid
    end
  end
end

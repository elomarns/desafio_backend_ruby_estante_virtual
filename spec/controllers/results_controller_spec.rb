require "rails_helper"

RSpec.describe ResultsController, type: :controller do
  before(:each) do
    @competition = Competition.create(name: "Fortnite BR",
                                      unit: "kills",
                 criterion_for_best_result: "min")
    @athlete = Athlete.create(name: "Elomar Nascimento dos Santos")
  end

  let(:valid_attributes) {
    {
      competition_id: @competition.id,
      athlete_id: @athlete.id,
      value: 99
    }
  }

  let(:invalid_attributes) {
    {
      competition_id: nil,
      athlete_id: nil,
      value: nil
    }
  }

  let(:valid_session) { {} }

  describe "GET #show" do
    it "returns a success response" do
      result = Result.create! valid_attributes
      get :show, params: { id: result.to_param, format: :json },
        session: valid_session
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new result" do
        expect {
          post :create, params: { format: :json }.merge(valid_attributes),
            session: valid_session
        }.to change(Result, :count).by(1)
      end

      it "renders a JSON response with the new result" do
        post :create, params: { format: :json }.merge(valid_attributes),
          session: valid_session
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq("application/json")
        expect(response.location).to eq(result_url(Result.last))
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new results" do
        post :create, params: { format: :json }.merge(invalid_attributes),
          session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end
end

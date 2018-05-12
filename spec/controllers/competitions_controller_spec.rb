require "rails_helper"

RSpec.describe CompetitionsController, type: :controller do
  let(:valid_attributes) {
    {
      name: "Salto naquele negócio lá",
      unit: "m"
    }
  }

  let(:invalid_attributes) {
    {
      name: nil,
      unit: nil,
      finished: nil,
      results_limit_per_athlete: nil,
      criterion_for_best_result: nil
    }
  }

  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns a success response" do
      competition = Competition.create! valid_attributes
      get :index, params: { format: :json }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      competition = Competition.create! valid_attributes
      get :show, params: { id: competition.to_param, format: :json },
        session: valid_session
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new competition" do
        expect {
          post :create, params: { format: :json }.merge(valid_attributes),
            session: valid_session
        }.to change(Competition, :count).by(1)
      end

      it "renders a JSON response with the new competition" do
        post :create, params: { format: :json }.merge(valid_attributes),
          session: valid_session
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq("application/json")
        expect(response.location).to eq(competition_url(Competition.last))
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new competition" do
        post :create, params: { format: :json }.merge(invalid_attributes),
          session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "PATCH #update" do
    context "with valid params" do
      let(:new_attributes) {
        {
          name: "Salto naquele outro negócio lá"
        }
      }

      it "updates the requested competition" do
        competition = Competition.create! valid_attributes
        patch :update, params: { id: competition.to_param, format: :json }.merge(new_attributes),
          session: valid_session
        competition.reload
        expect(competition.name).to eq(new_attributes[:name])
      end

      it "renders a JSON response with the competition" do
        competition = Competition.create! valid_attributes
        patch :update, params: { id: competition.to_param, format: :json }.merge(valid_attributes),
          session: valid_session
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json")
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the competition" do
        competition = Competition.create! valid_attributes

        patch :update, params: { id: competition.to_param, format: :json }.merge(invalid_attributes),
          session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "PATCH #finish" do
    context "with valid params" do
      it "finishes the requested competition" do
        competition = Competition.create! valid_attributes
        patch :finish, params: { id: competition.to_param, format: :json },
          session: valid_session
        competition.reload
        expect(competition.finish).to eq(true)
      end

      it "renders a JSON response with the competition" do
        competition = Competition.create! valid_attributes
        patch :finish, params: { id: competition.to_param, format: :json },
          session: valid_session
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested competition" do
      competition = Competition.create! valid_attributes
      expect {
        delete :destroy, params: { id: competition.to_param, format: :json },
          session: valid_session
      }.to change(Competition, :count).by(-1)
    end
  end
end

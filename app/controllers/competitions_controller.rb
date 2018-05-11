class CompetitionsController < ApplicationController
  before_action :set_competition, only: [:show, :update, :finish, :destroy]

  # GET /competicoes
  def index
    @competitions = Competition.older_first
  end

  # GET /competicoes/1
  def show
  end

  # POST /competicoes
  def create
    @competition = Competition.new(competition_params)

    if @competition.save
      render :show, status: :created, location: @competition
    else
      render json: @competition.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /competicoes/1
  def update
    if @competition.update(competition_params)
      render :show
    else
      render json: @competition.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /competicoes/1/finalizar
  def finish
    @competition.finish

    render :show
  end

  # DELETE /competicoes/1
  def destroy
    @competition.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_competition
      @competition = Competition.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def competition_params
      params.permit(:name, :unit, :finished, :results_limit_per_athlete, :criterion_for_best_result)
    end
end

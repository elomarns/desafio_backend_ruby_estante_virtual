class ResultsController < ApplicationController
  before_action :set_competition, only: :create
  before_action :set_athlete, only: :create
  before_action :set_result, only: :show

  # GET /resultados/1
  def show
  end

  # POST /resultados
  def create
    @result = Result.new(result_params)

    if @result.save
      render :show, status: :created, location: @result
    else
      render json: @result.errors, status: :unprocessable_entity
    end
  end

  private
  def set_competition
    if params[:competition].present? and not params[:competition_id].present?
      if params[:unit].present?
        competition = Competition.where(name: params[:competition],
                                        unit: params[:unit]).first_or_create
      else
        competition = Competition.where(name: params[:competition]).first
      end

      params[:competition_id] = competition.try(:id)
    end
  end

  def set_athlete
    if params[:athlete].present? and not params[:athlete_id].present?
      athlete = Athlete.where(name: params[:athlete]).first_or_create

      params[:athlete_id] = athlete.id
    end
  end

  def set_result
    @result = Result.find(params[:id])
  end

  def result_params
    params.permit(:competition_id, :athlete_id, :value)
  end
end

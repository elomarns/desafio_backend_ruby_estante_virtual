json.extract! competition, :id, :name, :unit, :finished, :results_limit_per_athlete,
                           :criterion_for_best_result, :created_at, :updated_at

if include_ranking
  json.ranking do
    json.partial! 'results/result', collection: competition.ranking, as: :result,
      include_competition: false, include_athlete: true
  end
end

json.url competition_url(competition, format: :json)

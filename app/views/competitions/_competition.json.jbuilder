json.extract! competition, :id, :name, :unit, :finished, :results_limit_per_athlete,
                           :criterion_for_best_result, :created_at, :updated_at
json.url competition_url(competition, format: :json)

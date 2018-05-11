FactoryBot.define do
  factory :competition do
    name "100m classificatoria 1"
    unit "s"
  end

  factory :competition_with_multiple_results_per_athlete, class: Competition do
    name "Lançamento de Dardo semifinal"
    unit "m"
    results_limit_per_athlete 3
    criterion_for_best_result "max"
  end
end

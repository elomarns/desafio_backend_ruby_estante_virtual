FactoryBot.define do
  factory :result do
    competition
    athlete
    value 9.5
  end

  factory :result_from_competition_with_multiple_results_per_athlete, class: Result do
    association :competition, factory: :competition_with_multiple_results_per_athlete
    athlete
    value 89.8
  end
end

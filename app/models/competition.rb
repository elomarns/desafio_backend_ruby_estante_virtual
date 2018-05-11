class Competition < ApplicationRecord
  validates :name,
    presence: true,
    uniqueness: { allow_blank: true, case_sensitive: false }

  validates :unit,
    presence: true

  validates :results_limit_per_athlete,
    presence: true,
    numericality: { only_integer: true, greater_than: 0 }

  validates :criterion_for_best_result,
    presence: true,
    inclusion: { in: %w(min max) }

  scope :older_first, -> { order(id: :asc) }

  def finish
    update finished: true
  end
end

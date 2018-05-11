class Competition < ApplicationRecord
  has_many :results, dependent: :destroy
  has_many :athletes, -> { distinct }, through: :results

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

  def ranking
    results
      .select("*", "#{criterion_for_best_result}(value) as value")
      .group(:athlete_id)
      .order(value: order_for_results)
  end

  def winner_result
    if finished?
      ranking.first
    end
  end

  private
  def order_for_results
    criterion_for_best_result == "max" ? "desc" : "asc"
  end
end

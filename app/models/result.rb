class Result < ApplicationRecord
  belongs_to :competition
  belongs_to :athlete

  validate :competition_is_not_finished
  validate :athlete_must_be_inside_the_limit_for_competition

  validates :value,
    presence: true,
    numericality: { greater_than: 0 }

  scope :from_athlete, -> (athlete) { where(athlete: athlete) }

  protected
  def competition_is_not_finished
    if competition.try(:finished?)
      error_message = I18n.t("activerecord.errors.models.result.attributes.competition.finished")
      self.errors.add(:competition, error_message)
    end
  end

  def athlete_must_be_inside_the_limit_for_competition
    if competition and athlete
      amount_of_results = competition.results.from_athlete(athlete).count
      results_limit = competition.results_limit_per_athlete

      if amount_of_results >= results_limit
        error_message = I18n.t("activerecord.errors.models.result.attributes.athlete.reached_limit_on_competition")
        self.errors.add(:athlete)
      end
    end
  end
end

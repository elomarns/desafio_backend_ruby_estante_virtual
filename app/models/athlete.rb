class Athlete < ApplicationRecord
  validates :name,
    presence: true,
    uniqueness: { allow_blank: true, case_sensitive: false }
end

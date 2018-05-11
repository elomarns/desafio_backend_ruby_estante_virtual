json.id result.id

if include_competition
  json.competition do
    json.partial! "competitions/competition", competition: result.competition
  end
end

if include_athlete
  json.athlete do
    json.partial! "athletes/athlete", athlete: result.athlete
  end
end

json.extract! result, :value, :created_at, :updated_at

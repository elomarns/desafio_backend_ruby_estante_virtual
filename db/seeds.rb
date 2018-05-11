# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
one_hundred_metres = Competition.create(name: "100m rasos classificatoria 1",
                                        unit: "s",
                   criterion_for_best_result: :min)

darts = Competition.create(name: "Lançamento de Dardo final",
                           unit: "m",
      results_limit_per_athlete: 3)

joao_das_neves = Athlete.create(name: "João das Neves")
joao_das_selvas = Athlete.create(name: "João das Selvas")
joao_dos_pantanos = Athlete.create(name: "João dos Pântanos")
joao_das_montanhas = Athlete.create(name: "João das Montanhas")

Result.create(competition: one_hundred_metres, athlete: joao_das_neves, value: 9.5)
Result.create(competition: one_hundred_metres, athlete: joao_das_selvas, value: 9.9)

Result.create(competition: darts, athlete: joao_dos_pantanos, value: 83.5)
Result.create(competition: darts, athlete: joao_dos_pantanos, value: 85.3)
Result.create(competition: darts, athlete: joao_dos_pantanos, value: 87.1)
Result.create(competition: darts, athlete: joao_das_montanhas, value: 82.2)
Result.create(competition: darts, athlete: joao_das_montanhas, value: 83.4)
Result.create(competition: darts, athlete: joao_das_montanhas, value: 85.5)

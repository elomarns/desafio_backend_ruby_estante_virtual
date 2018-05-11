class CreateCompetitions < ActiveRecord::Migration[5.2]
  def change
    create_table :competitions do |t|
      t.string :name
      t.string :unit
      t.boolean :finished, default: false
      t.integer :results_limit_per_athlete, default: 1
      t.string :criterion_for_best_result, default: :max

      t.timestamps
    end

    add_index :competitions, :name, unique: true
  end
end

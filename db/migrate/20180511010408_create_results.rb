class CreateResults < ActiveRecord::Migration[5.2]
  def change
    create_table :results do |t|
      t.references :competition, foreign_key: true
      t.references :athlete, foreign_key: true
      t.float :value

      t.timestamps
    end
  end
end

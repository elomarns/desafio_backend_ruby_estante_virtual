class CreateAthletes < ActiveRecord::Migration[5.2]
  def change
    create_table :athletes do |t|
      t.string :name

      t.timestamps
    end

    add_index :athletes, :name, unique: true
  end
end

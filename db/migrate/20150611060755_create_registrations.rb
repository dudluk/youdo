class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.integer :valid_for
      t.references :dog, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

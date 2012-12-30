class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :description
      t.integer :eid
      t.string :location
      t.string :name
      t.datetime :start_time
      t.datetime :end_time
      t.integer :creator

      t.timestamps
    end
    add_index :events, [:creator, :created_at]
  end
end

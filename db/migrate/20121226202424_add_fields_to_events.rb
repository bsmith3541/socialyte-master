class AddFieldsToEvents < ActiveRecord::Migration
  def up
  	#rename_column :events, :user_id, :creator
  	remove_column :events, :content
  	add_column :events, :eid, :integer
  	add_column :events, :start_time, :datetime
  	add_column :events, :end_time, :datetime
  	add_column :events, :location, :string
  	add_column :events, :name, :string
  end

  def down
  	remove_column :events, :creator
  	remove_column :events, :eid
  	remove_column :events, :start_time
  	remove_column :events, :end_time
  	remove_column :events, :location
  	remove_column :events, :name
  end
end

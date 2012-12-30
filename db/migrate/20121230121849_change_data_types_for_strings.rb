class ChangeDataTypesForStrings < ActiveRecord::Migration
  def up
  	change_column :events, :description, :text, :limit => nil
  	change_column :events, :eid, :text, :limit => nil
  	change_column :events, :location, :text, :limit => nil
  	change_column :events, :name, :text, :limit => nil
  	change_column :events, :creator, :text, :limit => nil
  end

  def down
  	change_column :events, :description, :string
  	change_column :events, :eid, :string
  	change_column :events, :location, :string
  	change_column :events, :name, :string
  	change_column :events, :creator, :string
  end
end

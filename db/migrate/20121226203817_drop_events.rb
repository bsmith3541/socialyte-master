class DropEvents < ActiveRecord::Migration
  def up
  	drop_table :events
  end
end

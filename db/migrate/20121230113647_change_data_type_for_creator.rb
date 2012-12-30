class ChangeDataTypeForCreator < ActiveRecord::Migration
  def up
  	change_table :events do |t|
  		t.change :eid, :bigint
  	end
  end

  def down
  	change_table :events do |t|
  		t.change :eid, :integer
  	end
  end
end

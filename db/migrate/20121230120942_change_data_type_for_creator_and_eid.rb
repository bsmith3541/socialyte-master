class ChangeDataTypeForCreatorAndEid < ActiveRecord::Migration
	def up
  	change_table :events do |t|
  		t.change :eid, :string
  		t.change :creator, :string
  	end
  end

  def down
  	change_table :events do |t|
  		t.change :eid, :integer
  		t.change :creator, :integer
  	end
  end
end

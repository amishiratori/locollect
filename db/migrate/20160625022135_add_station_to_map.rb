class AddStationToMap < ActiveRecord::Migration
  def change
    add_column :maps, :station_id, :integer
  end
end

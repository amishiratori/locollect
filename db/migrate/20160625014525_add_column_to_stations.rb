class AddColumnToStations < ActiveRecord::Migration
  def change
    add_column :stations, :address, :string
  end
end

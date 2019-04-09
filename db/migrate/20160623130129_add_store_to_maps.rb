class AddStoreToMaps < ActiveRecord::Migration
  def change
    add_column :maps, :good, :integer, default: 0
    add_column :maps, :stores, :string
  end
end

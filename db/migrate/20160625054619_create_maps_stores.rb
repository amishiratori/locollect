class CreateMapsStores < ActiveRecord::Migration
  def change
    create_table :maps_stores, id: false do |t|
      t.references :map, index: true, null: false
      t.references :store, index: true, null: false
    end
  end
end

class CreateConnections < ActiveRecord::Migration
  def change
    create_table :connections do |t|
      t.references :user
      t.references :connected_user
      t.integer :count, default: 1
      t.timestamps
    end
  end
end

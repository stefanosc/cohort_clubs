class CreateClubs < ActiveRecord::Migration
  def change
    create_table :clubs do |t|
      t.string :name
      t.references :cohort
      t.timestamps
    end
  end
end

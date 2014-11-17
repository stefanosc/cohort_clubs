class AddClubIdToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :club
  end
end

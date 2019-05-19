class AddUserRefToTravels < ActiveRecord::Migration
  def change
    add_reference :travels, :user, index: true, foreign_key: true
  end
end

class AnyMigration < ActiveRecord::Migration
  def change
    add_foreign_key :events, :days
  end
end

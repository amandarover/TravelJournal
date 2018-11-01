class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :type
      t.string :name
      t.string :address
      t.datetime :starting_time
      t.datetime :ending_time
      t.float :pricing
      t.string :description

      t.timestamps null: false
    end
  end
end

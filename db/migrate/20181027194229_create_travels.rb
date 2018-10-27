class CreateTravels < ActiveRecord::Migration
  def change
    create_table :travels do |t|
      t.string :name
      t.string :destination
      t.datetime :init_date
      t.datetime :final_date
      t.text :description

      t.timestamps null: false
    end
  end
end

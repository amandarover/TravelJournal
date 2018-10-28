class CreateDays < ActiveRecord::Migration
  def change
    create_table :days do |t|
      t.date :date
      t.references :travel, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

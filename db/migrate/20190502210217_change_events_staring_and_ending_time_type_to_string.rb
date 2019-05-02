class ChangeEventsStaringAndEndingTimeTypeToString < ActiveRecord::Migration
  def change
    change_column :events, :starting_time, :string
    change_column :events, :ending_time, :string
  end
end

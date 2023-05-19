class RemoveExampleColumnFromHabits < ActiveRecord::Migration[6.0]
  def change
    remove_column :habits, :achieved, :integer
  end
end

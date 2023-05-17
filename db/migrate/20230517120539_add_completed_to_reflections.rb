class AddCompletedToReflections < ActiveRecord::Migration[6.0]
  def change
    add_column :reflections, :completed, :boolean
  end
end

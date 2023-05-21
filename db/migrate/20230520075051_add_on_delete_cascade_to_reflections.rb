class AddOnDeleteCascadeToReflections < ActiveRecord::Migration[6.0]
  def up
    remove_foreign_key :reflections, :values
    add_foreign_key :reflections, :values, on_delete: :cascade
  end

  def down
    remove_foreign_key :reflections, :values
    add_foreign_key :reflections, :values
  end
end

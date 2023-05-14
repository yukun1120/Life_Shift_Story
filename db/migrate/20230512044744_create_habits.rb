class CreateHabits < ActiveRecord::Migration[6.0]
  def change
    create_table :habits do |t|
      t.string :item, null: false
      t.integer :achieved
      t.boolean :check
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end

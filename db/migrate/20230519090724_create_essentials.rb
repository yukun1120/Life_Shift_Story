class CreateEssentials < ActiveRecord::Migration[6.0]
  def change
    create_table :essentials do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.datetime :start_time, null:false
      t.datetime :end_time, null:false
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end

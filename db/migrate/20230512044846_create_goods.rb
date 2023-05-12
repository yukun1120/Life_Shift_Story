class CreateGoods < ActiveRecord::Migration[6.0]
  def change
    create_table :goods do |t|
      t.text :good_thing, null: false
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end

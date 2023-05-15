class CreateFamousQuotes < ActiveRecord::Migration[6.0]
  def change
    create_table :famous_quotes do |t|
      t.string :phrase, null: false
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end

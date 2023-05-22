class CreateUserinquiries < ActiveRecord::Migration[6.0]
  def change
    create_table :userinquiries do |t|
      t.string :title, null: false
      t.string :content, null: false
      t.references :user, null: false
      t.timestamps
    end
  end
end

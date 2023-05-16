class AddDisplayedToFamousQuotes < ActiveRecord::Migration[6.0]
  def change
    add_column :famous_quotes, :displayed, :boolean, default: false
  end
end

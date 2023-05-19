class CreateLifeLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :life_logs do |t|

      t.timestamps
    end
  end
end

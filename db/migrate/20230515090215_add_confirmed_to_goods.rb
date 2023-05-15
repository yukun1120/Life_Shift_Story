class AddConfirmedToGoods < ActiveRecord::Migration[6.0]
  def change
    add_column :goods, :confirmed, :boolean, default: false
  end
end

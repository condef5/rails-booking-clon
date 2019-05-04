class AddValidTokenToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :valid_token, :string
  end
end

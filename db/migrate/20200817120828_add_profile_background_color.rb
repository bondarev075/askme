class AddProfileBackgroundColor < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :profile_bg_color, :string
  end
end

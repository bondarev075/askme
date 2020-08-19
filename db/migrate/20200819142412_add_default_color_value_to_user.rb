class AddDefaultColorValueToUser < ActiveRecord::Migration[6.0]
  def change
    change_column_default :users, :profile_bg_color, from: nil, to: "#005a55"
  end
end

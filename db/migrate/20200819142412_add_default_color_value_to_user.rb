class AddDefaultColorValueToUser < ActiveRecord::Migration[6.0]
  def change
    change_column_default :users, :profile_bg_color, from: nil, to: "#005a55"

    reversible do |dir|
      dir.up { User.where(profile_bg_color: nil).update_all(profile_bg_color: '#005a55') }
    end
  end
end

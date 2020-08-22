class ChangeAuthorToAuthorId < ActiveRecord::Migration[6.0]
  def change
    rename_column :questions, :author, :author_id
  end
end

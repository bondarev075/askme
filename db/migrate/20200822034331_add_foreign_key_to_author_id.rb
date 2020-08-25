class AddForeignKeyToAuthorId < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :questions, :users, column: :author_id
  end
end

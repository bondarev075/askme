class AddForeignKeyToAuthorId < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :questions, :users, column: :author_id, primary_key: "id"
  end
end

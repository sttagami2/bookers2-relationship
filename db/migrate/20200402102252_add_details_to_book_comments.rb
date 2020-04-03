class AddDetailsToBookComments < ActiveRecord::Migration[5.2]
  def change
    add_column :book_comments, :user_id, :integer
  end
end

class AddCommentsToPostId < ActiveRecord::Migration
  def change
    #add_column :comments, :post_id,:integer

    #change_table :comments do |t|
    # t.integer :post_id

    #add_reference :comments, :post

    add_belongs_to :comments, :post
  end
end




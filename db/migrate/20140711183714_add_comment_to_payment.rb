class AddCommentToPayment < ActiveRecord::Migration
  def up
    add_column :payments, :comment, :text
  end

  def down
    remove_column :payments, :comment
  end
end

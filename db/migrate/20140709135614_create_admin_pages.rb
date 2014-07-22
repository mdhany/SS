class CreateAdminPages < ActiveRecord::Migration
  def change
    create_table :admin_pages do |t|
      t.string :title
      t.string :url
      t.text :content

      t.timestamps
    end
  end
end

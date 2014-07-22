class Add1000ToUserId < ActiveRecord::Migration
  def change
    execute ('ALTER TABLE users AUTO_INCREMENT = 10000')
  end
end

class AddOwnership < ActiveRecord::Migration
  def self.up
    change_table :recipes do |t|
      t.integer :user_id
    end
    change_table :batches do |t|
      t.integer :user_id
    end
    
    Recipe.update_all ["user_id = ?", 1]
    Batch.update_all ["user_id = ?", 1]
  end

  def self.down
    remove_column :recipes, :user_id
    remove_column :batches, :user_id
  end
end

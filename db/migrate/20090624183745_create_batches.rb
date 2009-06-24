class CreateBatches < ActiveRecord::Migration
  def self.up
    create_table :batches do |t|
      t.integer :recipe_id
      t.date :brewed_on
      t.text :notes

      t.timestamps
    end
  end

  def self.down
    drop_table :batches
  end
end

class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.string :identifier

      t.references :user, index: true
      t.attachment :file

      t.string :target_type
      t.string :target_attr

      t.timestamps

      t.index :identifier
    end
  end
end

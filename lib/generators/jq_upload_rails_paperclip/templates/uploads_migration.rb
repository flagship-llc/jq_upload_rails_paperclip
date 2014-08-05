class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.references :user, index: true
      t.attachment :file

      t.string :target_type
      t.string :target_attr

      t.timestamps
    end
  end
end

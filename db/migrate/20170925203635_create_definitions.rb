class CreateDefinitions < ActiveRecord::Migration[5.1]
  def change
    create_table :definitions do |t|
      t.string :text
      t.references :entry, foreign_key: true

      t.timestamps
    end
  end
end

class CreateEntriesDefinitions < ActiveRecord::Migration[5.1]
  def change
    create_table :entries_definitions do |t|
      t.references :entry, foreign_key: true
      t.references :definition, foreign_key: true

      t.timestamps
    end
  end
end

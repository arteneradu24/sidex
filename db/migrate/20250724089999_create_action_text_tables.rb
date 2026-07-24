# frozen_string_literal: true

class CreateActionTextTables < ActiveRecord::Migration[8.1]
  def change
    create_table :action_text_rich_texts, id: :primary_key do |t|
      t.string     :name, null: false
      t.text :body
      t.references :record, null: false, polymorphic: true, index: false
      t.timestamps
    end

    add_index :action_text_rich_texts, %i[record_type record_id name], name: "index_action_text_rich_texts_uniqueness", unique: true
  end
end

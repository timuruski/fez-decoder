class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :name
      t.text :cipher_text
      t.text :clear_text
      t.string :coordinates

      t.timestamps
    end
  end
end

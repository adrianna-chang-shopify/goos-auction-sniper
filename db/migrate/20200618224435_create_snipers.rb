class CreateSnipers < ActiveRecord::Migration[6.0]
  def change
    create_table :snipers do |t|
      t.string :item_id, null: false
      t.string :status, null: false, default: 'joining'

      t.timestamps
    end
  end
end

class DropOpinions < ActiveRecord::Migration[7.0]
  def change
    drop_table :opinions do |t|
      t.string :category, null: false

      t.timestamps
    end
  end
end

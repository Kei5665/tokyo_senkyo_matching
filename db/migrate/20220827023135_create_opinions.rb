class CreateOpinions < ActiveRecord::Migration[7.0]
  def change
    create_table :opinions do |t|
      t.string :category, null: false

      t.timestamps
    end
  end
end

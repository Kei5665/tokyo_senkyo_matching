class CreatePartyQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :party_questions do |t|
      t.references :questions, null: false, foreign_key: true
      t.references :parties, null: false, foreign_key: true
      t.integer :opinion, null: false

      t.timestamps
    end
  end
end

class ChangeOpinionCulumnFromIntegerReferences < ActiveRecord::Migration[7.0]
  def change
    remove_column :party_questions, :opinion, :integer, null: false
    add_reference :party_questions, :opinion, foreign_key: true
  end
end

class User < ApplicationRecord
  has_many :user_parties, dependent: :destroy
  has_many :user_questions, dependent: :destroy

  authenticates_with_sorcery!

  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :email, uniqueness: true, allow_nil: true

  enum :role, { general: 0, admin: 1 }

  # user.user_partiesの中身となるデータを配列形式で一括生成して、DBへ挿入
  def create_party_relation
    record_array = Party.pluck(:id).map {|party_id| { user_id: self.id, party_id: party_id, point: 0 } }
    UserParty.insert_all(record_array)
  end

  # ユーザーの回答をDBに保存
  def save_result(question, result)
    user_questions.create(question_id: question.id, result: result)
  end
end

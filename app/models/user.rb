class User < ApplicationRecord
  has_many :user_parties, dependent: :destroy
  has_many :user_questions, dependent: :destroy

  authenticates_with_sorcery!
  # ゲストログインのため、一旦password validationを外す
  # validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  # validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  # validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true, allow_nil: true

  enum :role, { general: 0, admin: 1 }

  # user.user_partiesの中身となるデータを配列形式で一括生成して、DBへ挿入
  def create_party_relation
    record_array = Party.pluck(:id).map { |party_id| { user_id: self.id, party_id: party_id, point: 0 } }
    UserParty.insert_all(record_array)
  end
end

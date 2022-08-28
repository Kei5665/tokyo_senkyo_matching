class User < ApplicationRecord
  has_many :user_parties, dependent: :destroy
  has_many :user_questions, dependent: :destroy

  # authenticates_with_sorcery!
  # validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  # validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  # validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true, allow_nil: true

  enum :role, { general: 0, admin: 1 }

  def party_relation
    parties = Party.all
    parties.each do |party|
      UserParty.create!(user_id: self.id, party_id: party.id, point: 0)
    end
  end

  def question_relation
    questions = Question.all
    questions.each do |question|
      UserQuestion.create!(user_id: self.id, question_id: question.id)
    end
  end
end

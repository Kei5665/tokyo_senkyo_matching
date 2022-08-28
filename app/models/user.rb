class User < ApplicationRecord
  has_many: :user_parties
  has_many: :user_questions

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

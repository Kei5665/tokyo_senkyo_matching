class UserParty < ApplicationRecord
  belongs_to :user
  belongs_to :party

  def calculate_point(user_question)
    # user = current_user
    user = User.find(1)
    party_questions = PartyQuestion.where(question_id: user_question.question_id)
    party_question = party_questions.find_by(party_id: party_id)
    user_result = user_question.result

    if user_question.agree_with_party(party_question)
      add_point(user_result)
    elsif user_question.disagree_with_party(party_question)
      reduce_point(user_result)
    end
  end

  def add_point(user_result)
    if user_result == "great"
      self.point += 2
      save
    elsif user_result == "good"
      self.point += 1
      save
    end
  end

  def reduce_point(user_result)
    self.point -= 1
    save
  end
end

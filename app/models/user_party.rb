class UserParty < ApplicationRecord
  belongs_to :user
  belongs_to :party

  # ユーザーに紐づいた政党のpointを降順に並べて取得する
  scope :ranking, -> { order(point: :desc) }

  def calculate_point(user_question)
    # 政党意見を参照するため、party_questionsテーブルから政党を取得してopinionを参照する
    party_questions = PartyQuestion.where(question_id: user_question.question_id)
    party_question = party_questions.find_by(party_id: party_id)
    # ユーザーの選択意見
    user_result = user_question.result

    # ユーザーと政党の意見が一致する場合、政党pointを加点する
    if user_question.agree_with_party?(party_question)
      add_point(user_result)
    # ユーザーと政党の意見が正反対の場合、政党pointを減点する
    # 政党が中立やユーザー意見が無回答の場合は、処理なし
    elsif user_question.disagree_with_party?(party_question)
      reduce_point(user_result)
    end
  end

  # ユーザー意見が超賛成の場合、政党point+2
  # ユーザー意見が賛成の場合、政党point+1
  def add_point(user_result)
    case user_result
    when 'great'
      self.point += 2
      save
    when 'good'
      self.point += 1
      save
    end
  end

  # ユーザーと政党が正反対の場合合、政党point-1
  def reduce_point(user_result)
    self.point -= 1
    save
  end
end

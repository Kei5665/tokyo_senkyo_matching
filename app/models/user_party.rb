class UserParty < ApplicationRecord
  belongs_to :user
  belongs_to :party

  # ユーザーに紐づいた政党のpointを降順に並べて取得する
  scope :ranking, -> { order(point: :desc) }

  def self.calculate_point(question, user_result)
    # 該当質問に賛成意見を持つ政党リストを取得
    agree_party_ids = question.party_questions.where(opinion: :agree).pluck(:party_id)
    agree_user_parties = self.where('party_id IN (?)', agree_party_ids)

    # 該当質問に反対意見を持つ政党リストを取得
    disagree_party_ids = question.party_questions.where(opinion: :disagree).pluck(:party_id)
    disagree_user_parties = self.where('party_id IN (?)', disagree_party_ids)

    case user_result
    when 'great'
      agree_user_parties.update_all('point = point + 2')
      disagree_user_parties.update_all('point = point - 1')
    when 'good'
      agree_user_parties.update_all('point = point + 1')
      disagree_user_parties.update_all('point = point - 1')
    when 'bad'
      agree_user_parties.update_all('point = point - 1')
      disagree_user_parties.update_all('point = point + 1')
    end
  end
end

class Question < ApplicationRecord
  validates :content, presence: true
  has_many :user_questions, dependent: :destroy
  has_many :party_questions, dependent: :destroy

  # 次の質問ページへ遷移するため、次の質問を取得する
  def next_question
    Question.find_by('id > ?', id)
  end
end

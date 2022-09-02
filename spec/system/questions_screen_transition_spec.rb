require 'rails_helper'

RSpec.describe 'Questions', type: :system do
  let(:party1) { create :party, name: '政党_1' }
  let(:question1) { create :question, content: '議題_1' }
  let(:question2) { create :question, content: '議題_2' }
  let(:question3) { create :question, content: '議題_3' }
  let(:party1_agree_question1) { create :party_question, party: party1, question: question1, opinion: :agree }
  let(:party1_agree_question2) { create :party_question, party: party1, question: question2, opinion: :agree }
  let(:party1_agree_question3) { create :party_question, party: party1, question: question3, opinion: :agree }
  let(:party_ranking_points) { UserParty.joins(:party).order(point: :desc).pluck(:point) }

  before do
    party1_agree_question1
    party1_agree_question2
    party1_agree_question3
    visit root_path
    click_on 'スタート'
    click_on '超賛成'
    click_on '超賛成'
  end

  describe '質問ページ遷移機能' do
    context '次の質問が存在する場合' do
      it '次の質問ページへ遷移する' do
        expect(page).to have_content '議題_3'
      end
    end

    context '次の質問が存在しない場合' do
      it '結果ページへ遷移する' do
        click_on '超賛成'
        expect(page).to have_content '政党_1'
        expect(party_ranking_points).to eq([6])
      end
    end
  end
end
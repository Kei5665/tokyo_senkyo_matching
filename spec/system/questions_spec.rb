require 'rails_helper'

RSpec.describe 'Questions', type: :system do
  let(:party1) { create :party, name: '政党_1' }
  let(:party2) { create :party, name: '政党_2' }
  let(:question1) { create :question, content: '議題_1' }
  let(:question2) { create :question, content: '議題_2' }
  let(:party1_agree_question1) { create :party_question, party: party1, question: question1, opinion: :agree }
  let(:party1_agree_question2) { create :party_question, party: party1, question: question2, opinion: :agree }
  let(:party2_disagree_question1) { create :party_question, party: party2, question: question1, opinion: :disagree }
  let(:party2_disagree_question2) { create :party_question, party: party2, question: question2, opinion: :disagree }
  let(:party_ranking_names) { UserParty.joins(:party).order(point: :desc).pluck(:name) }
  let(:party_ranking_points) { UserParty.joins(:party).order(point: :desc).pluck(:point) }

  before do
    party1_agree_question1
    party2_disagree_question1
    visit root_path
    click_on 'スタート'
  end

  describe '個別質問に対しての政党ポイント計算機能' do
    context 'ユーザが超賛成を押した場合' do
      before {click_on '超賛成'}
      it '賛成意見を持つ政党のポイントが2点で、反対意見を持つ政党のポイントが-1点になる' do
        expect(page).to have_content '政党_1'
        expect(party_ranking_names).to eq(['政党_1', '政党_2'])
        expect(party_ranking_points).to eq([2, -1])
      end
    end

    context 'ユーザが賛成を押した場合' do
      before {click_on '賛成'}
      it '賛成意見を持つ政党のポイントが1点で、反対意見を持つ政党のポイントが-1点になる' do
        expect(page).to have_content '政党_1'
        expect(party_ranking_names).to eq(['政党_1', '政党_2'])
        expect(party_ranking_points).to eq([1, -1])
      end
    end

    context 'ユーザが反対を押した場合' do
      before {click_on '反対'}
      it '賛成意見を持つ政党のポイントが-1点で、反対意見を持つ政党のポイントが1点になる' do
        expect(page).to have_content '政党_2'
        expect(party_ranking_names).to eq(['政党_2', '政党_1'])
        expect(party_ranking_points).to eq([1, -1])
      end
    end

    context 'ユーザが無回答を押した場合' do
      before {click_on '無回答'}
      it 'どちらの政党ポイントも0点のまま' do
        expect(page).to have_content '政党_1'
        expect(party_ranking_names).to eq(['政党_1', '政党_2'])
        expect(party_ranking_points).to eq([0, 0])
      end
    end
  end

  describe '複数質問に対しての政党ポイント集計機能' do
    before do
      party1_agree_question2
      party2_disagree_question2
      click_on '無回答'
      expect(page).to have_content '議題_2'
    end

    context '一つ目は無回答で、次の質問はユーザが超賛成を押した場合' do
      before {click_on '超賛成'}
      it '賛成意見を持つ政党のポイント合計が2点で、反対意見を持つ政党のポイント合計が-1点になる' do
        expect(page).to have_content '政党_1'
        expect(party_ranking_names).to eq(['政党_1', '政党_2'])
        expect(party_ranking_points).to eq([2, -1])
      end
    end

    context '一つ目は無回答で、ユーザが賛成を押した場合' do
      before {click_on '賛成'}
      it '賛成意見を持つ政党のポイントが1点で、反対意見を持つ政党のポイントが-1点になる' do
        expect(page).to have_content '政党_1'
        expect(party_ranking_names).to eq(['政党_1', '政党_2'])
        expect(party_ranking_points).to eq([1, -1])
      end
    end

    context '一つ目は無回答で、次の質問はユーザが反対を押した場合' do
      before {click_on '反対'}
      it '賛成意見を持つ政党のポイント合計が-1点で、反対意見を持つ政党のポイント合計が1点になる' do
        expect(page).to have_content '政党_2'
        expect(party_ranking_names).to eq(['政党_2', '政党_1'])
        expect(party_ranking_points).to eq([1, -1])
      end
    end

    context '一つ目は無回答で、次の質問はユーザが無回答を押した場合' do
      before {click_on '無回答'}
      it 'どちらの政党ポイントも0点のまま' do
        expect(page).to have_content '政党_1'
        expect(party_ranking_names).to eq(['政党_1', '政党_2'])
        expect(party_ranking_points).to eq([0, 0])
      end
    end
  end
end

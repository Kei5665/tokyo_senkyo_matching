class StaticPagesController < ApplicationController
  def top; end

  def result
    user_parties = UserParty.where(user_id: current_user.id)
    @results = user_parties.ranking

    parties = []

    @results.each do |result|
      party_name = result.party.name
      parties.push(party_name)
    end
    gon.parties = parties
  end
end

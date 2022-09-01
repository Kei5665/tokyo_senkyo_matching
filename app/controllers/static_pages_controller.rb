class StaticPagesController < ApplicationController
  def top
  end

  def about; end

  def result
    user_parties = UserParty.where(user_id: current_user.id)
    @results = user_parties.ranking

    parties = []
    points = []

    @results.each do |result|
      point = result.point
      party_name = result.party.name
      parties.push(party_name)
      points.push(point)
    end
    gon.parties = parties
    gon.points = points
  end
end

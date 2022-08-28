class StaticPagesController < ApplicationController
  def top; end

  def result
    user_parties = UserParty.where(user_id: current_user.id)
    @results = user_parties.ranking
  end
end

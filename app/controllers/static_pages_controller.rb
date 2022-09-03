class StaticPagesController < ApplicationController
  def top; end

  def about; end

  def result
    user_parties = current_user.user_parties.ranking

    @parties = user_parties.joins(:party).pluck(:name)
    points = user_parties.pluck(:point)

    gon.parties = @parties
    gon.points = points
  end
end

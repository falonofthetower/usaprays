class LeadersController < ApplicationController
  layout "templates/states"

  def index
    @state = UsState.new(params[:state_id])
  end

  def show
    @leader = LeaderFinder.find(params[:id])
    @state = @leader.state
  end

end

class StaticController < ApplicationController
  layout 'templates/states'

  def how_to_pray
    state_code = cookies[:state_code] || 'nc'
    @state = UsState.new(state_code)
    @day = params[:day]
    @day = nil if !@day.nil? && (@day<'1' || @day>'9')
  end
end

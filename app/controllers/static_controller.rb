class StaticController < ApplicationController
  layout 'templates/states'

  def how_to_pray
    state_code = cookies[:state_code] || 'nc'
    @state = UsState.new(state_code)
  end
end

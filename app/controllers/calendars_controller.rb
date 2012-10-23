class CalendarsController < ApplicationController
  layout "templates/states"

  def index

  end

  def show
    @state = UsState.new(params[:state_id])
    @segment = MailListSegment.new(@state, params[:id])
    @subscription = Subscription.new(
      state_code: params[:state_id],
      cycle: params[:id]
    )
  end
end

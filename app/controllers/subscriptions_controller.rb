class SubscriptionsController < ApplicationController
  layout "states"

  def create
    @state = UsState.new(params[:state_id])
    @subscription = Subscription.new(params[:subscription])
    if @subscription.save
      flash[:success] = "You have successfully subscribed to the #{@subscription.segment.public_name}"
    else
      flash[:error] = "Your subscription could not be created."
    end
    redirect_to state_calendar_path(@state.to_param, @subscription.cycle)
  end
end

class SubscriptionsController < ApplicationController
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

  def create
    @state = UsState.new(params[:state_id])
    @subscription = Subscription.new(params[:subscription])
    if @subscription.save
      flash[:success] = "You have successfully subscribed to the #{@subscription.segment.public_name}"
    else
      flash[:error] = "Your subscription could not be created."
    end
    redirect_to state_subscription_path(@state.to_param, @subscription.cycle)
  end
end

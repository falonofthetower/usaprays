class StatesController < ApplicationController
  layout "templates/states"

  def index
    render layout: "templates/application"
  end

  def show
    cookies[:state_code] = params[:id]
    @state = UsState.new(params[:id])
    # Change false to true to test in dev without hitting api
    if Rails.env == "development" and true
      @leaders = []
      6.times do
        @leaders << Leader.ron_paul
      end
    else
      @leaders = LegislatorSelector.today(@state)
    end
  end

  def daily_twitter_feed
    @state = UsState.new(params[:state_id])
    @legislators = LegislatorSelector.today(@state)
    @member0= @legislators[0]
    @member1= @legislators[1]
    @member2= @legislators[2]

    respond_to do |format|
      format.rss { render :layout => false } #index.rss.builder
    end
  end

  def daily_email_feed
    @date = Date.current
    @state = UsState.new(params[:state_id])
    @member0 = @state.member_zero(@date)
    @member1 = @state.member_one(@date)
    @member2 = @state.member_two(@date)

    respond_to do |format|
      format.rss { render :layout => false } #index.rss.builder
    end
  end

  def weekly_email_feed
    @date = Date.current
    @sunday = @date.next_week.next_day(6)
    @state = UsState.new(params[:state_id])

    respond_to do |format|
      format.html
      format.rss { render :layout => false } #index.rss.builder
    end
  end
end

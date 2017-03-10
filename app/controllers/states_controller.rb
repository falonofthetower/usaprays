class StatesController < ApplicationController
  before_filter :set_what_to_pray_for, :only => [:show, :email]

  layout "templates/states"

  def index
    render layout: "templates/application"
  end

  def show
    st = params[:id]
    unless st.nil?
      st.downcase!
      if UsState.names.has_key?(st)
        cookies[:state_code] = st
        @state = UsState.new(st)
        @leaders = LeaderSelector.for_day(@state, @date)
        respond_to do |format|
          format.html
          format.rss { render :layout => false } #show.rss.builder
        end
      else
        #redirect_to "#{Rails.root}/public/404"
        redirect_to "/public/404"
      end
    end
  end

  def email
    @state = UsState.new(params[:id])
    @leaders = LegislatorSelector.for_day(@state, @date)
    render layout: false
  end

  private

  def build_date
    DateBuilder.build_date(params)
  end

  def set_what_to_pray_for
    @date = build_date
    pray_for = Pray.new(@date)
    @what_to_pray_for_text = pray_for.text
    @what_to_pray_for_message = pray_for.message
    @what_to_pray_for_day = pray_for.day
  end
end

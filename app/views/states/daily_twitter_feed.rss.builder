xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Public Servants' Prayer Daily Calendar"
    xml.description "A Daily update of #{@state.name} legislators we are praying for" 
    xml.link "http://www.publicservantsprayer.org/states/#{params[:state_id]}/feed.rss"
    xml.item do
      xml.link daily_calendar_url(params[:state_id], Date.current.year, Date.current.month, Date.current.day)
      xml.guiddaily_calendar_url(params[:state_id], Date.current.year, Date.current.month, Date.current.day)
      xml.title "Please pray today for: #{@member0.prefix_name}, #{@member1.prefix_name}, #{@member2.prefix_name}"
    end
  end
end

xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Public Servants' Prayer List"
    xml.description "#{@state.name} legislators we are praying for" 
    xml.link "http://usaprays.com/states/#{params[:state_id]}/feed.rss"
    xml.item do
      xml.link state_date_url(params[:id], @date.year, @date.month, @date.day)
      xml.guid state_date_url(params[:id], @date.year, @date.month, @date.day)
      xml.title "Please pray today for the following leaders."
      xml.pubdate @date.to_time.to_s(:rfc822)
      xml.description do
        xml.cdata!("<h1>Leaders Being Prayed For Today</h1>")
        xml.cdata!("<h2>#{@date.strftime("%A, %B %-d, %Y")}</h2>")
        @leaders.each do |leader|
          xml.cdata!(render(partial: "leaders/profile_email_rss.html.erb", locals: { leader: leader }))
        end
      end
    end
  end
end

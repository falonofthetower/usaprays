xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Public Servants' Prayer Daily Calendar"
    xml.description "A Daily update of #{@state.name} legislators we are praying for" 
    xml.link "http://www.publicservantsprayer.org/states/#{params[:state_id]}/feed.rss"
    7.times do |i|
      date = @sunday + i
      @member0 = @state.member_zero(date)
      @member1 = @state.member_one(date)
      @member2 = @state.member_two(date)
      xml.item do
        xml.link weekly_calendar_url(params[:state_id], @date.year, @date.month, @date.day)
        xml.guid weekly_calendar_url(params[:state_id], @date.year, @date.month, @date.day)
        xml.title "Please pray today for: #{@member0.prefix_name}, #{@member1.prefix_name}, #{@member2.prefix_name}"
        xml.pubdate @date.to_time.to_s(:rfc822)
        xml.description do

          xml.cdata!("<h1>Legislators Being Prayed For On</h1>")
          xml.cdata!("<h2>#{@date.strftime("%A, %B %-d, %Y")}</h2>")
          xml.cdata!(render(partial: "members/profile_email_rss.html.erb", locals: { member: @member0 }))
          xml.cdata!(render(partial: "members/profile_email_rss.html.erb", locals: { member: @member1 }))
          xml.cdata!(render(partial: "members/profile_email_rss.html.erb", locals: { member: @member2 }))
        end
      end
    end
  end
end

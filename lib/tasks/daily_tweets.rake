require 'aws/s3'
require 'csv'
require 'oauth'

def prepare_access_token(consumer_key, consumer_secret, oauth_token, oauth_token_secret)
  consumer = OAuth::Consumer.new(ENV[consumer_key], ENV[consumer_secret],
                                 { :site => "https://api.twitter.com", :scheme => :header })
  token_hash = { :oauth_token => ENV[oauth_token], :oauth_token_secret => ENV[oauth_token_secret] }
  OAuth::AccessToken.from_hash(consumer, token_hash )
end

def last_name(name)
  # regex to find the last name of a person.
  # Comma followed by suffix (, Jr.) is ignored if present.
  name =~ /(\w*)\s*(,.*)*\z/
  $1
end

def send_email(email)
  RestClient.post api_url+"/messages",
    :from => "peterskarth@gmail.com",
    :to => "peterskarth@gmail.com",
    :subject => "Tweets #{Time.now}",
    :text => email
end

TITLE_ABBV = [
    # Legislators from http://knowwho
    ['US Representative', 'US Rep'],
    ['Representative', 'Rep'],
    ['US Senator', 'US Sen'],
    ['Senator', 'Sen'],
    ['Assemblymember', 'AM'],
    ['Delegate', 'Del'],
    # Executives from Refinery
    ['Governor', 'Gov'],
    ['Lt. Governor', 'LtGov'],
    ['Lt Governor', 'LtGov'],
    ['Secretary of State', 'SOS'],
    ['Attorney General', 'AG'],
    ['Secretary of the Commonwealth', 'SOC'],
    ['Senate President', 'SP'],
    ['Speaker of the House of Representatives', 'Spkr'],
    ['President Pro Tempore of Senate', 'Sen'],
    ['Vice President of the United States', 'VP'], # Order is important here...
    ['President of the United States', 'Pres'],
    # Justices from Refinery
    ['Associate Justice', 'AJ'],
    ['Chief Justice of the United States', 'CJ']
]

desc "Tweet to all the states"
task :daily_tweets => [:environment] do
  email_text = ""
  start=Time.now
  uniq = start.to_i.to_s
  email_text << ">>>>> #{start.strftime('%Y-%m-%d_%H:%M:%S')} (#{uniq}) Processing daily_tweets...\n"
  past_first_row = false
  CSV.foreach("twitter_states_credentials.csv") do |row|
    unless past_first_row
      past_first_row = true
      next
    end
    st=row[0].downcase
    @state = UsState.new(st)
    @leaders = LeaderSelector.for_day(@state, Date.today())

    tweet = "http://www.pray1tim2.org/s/#{st} Please pray for:\n"
    @leaders.each do |l|
      title = l.title || ''
      # unless title.blank?
      #   TITLE_ABBV.each do | title__abbv |
      #     if title.index(title__abbv[0])
      #       title = title__abbv[1]
      #       next
      #     end
      #   end
      # end


      if !title.blank?
        tweet += ' ' + title
          .gsub(/Associate Justice/, 'AJ')
          .gsub(/Chief Justice of the United States/, 'CJ')
          .gsub(/President/, 'Pres.')
          .gsub(/Vice President/, 'V.P.')
          .gsub(/Secretary of State/, 'SOS')
          .gsub(/Attorney General/, 'AG')
          .gsub(/Governor/, 'Gov.')

        if !l.twitter.blank?
          tweet += l.twitter.gsub("http://twitter.com/", "@")
        else
          tweet += ' ' + l.name
        end
        tweet += "\n"
      end
    end

    email_text << ">>>>>>>>>> #{Time.now.strftime('%Y-%m-%d@%H:%M:%S')} (#{uniq}) Tweeting: #{row.inspect} ---> #{tweet}\n"
    # Use the access token to post my status, Note that POSTing requires read/write access to the app and user
    update_hash = {'status' => tweet}
    access_token = prepare_access_token(row[1], row[2], row[3], row[4])

    response = access_token.post('https://api.twitter.com/1.1/statuses/update.json', update_hash, { 'Accept' => 'application/xml' })

    unless response.to_s =~ /.*HTTPOK/
      email_text << ">>>>>>>>>>>>>>> #{Time.now.strftime('%Y-%m-%d@%H:%M:%S')} (#{uniq}) Twitter Tweet Non 200 Response for #{st} is #{response.to_s}\n"
      email_text << ">>>>>>>>>>>>>>> (#{uniq}) response.body = #{response.body}\n" # unless response.body.blank?
    else
      email_text << response.body
    end
  end

  finish = Time.now
  email_text << ">>>>> #{finish.strftime('%Y-%m-%d_%H:%M:%S')} (#{uniq}) daily_tweets finished - #{(finish-start).round.to_s} seconds.\n"
  send_email(email_text)
end

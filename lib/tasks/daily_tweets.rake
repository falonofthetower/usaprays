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
  start=Time.now
  uniq = start.to_i.to_s
  Rails.logger.info ">>>>> #{start.strftime('%Y-%m-%d_%H:%M:%S')} (#{uniq}) Processing daily_tweets..."
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
        tweet += ' ' + l.name
        tweet += "\n"
      end
    end

    Rails.logger.info ">>>>>>>>>> #{Time.now.strftime('%Y-%m-%d@%H:%M:%S')} (#{uniq}) Tweeting: #{row.inspect} ---> #{tweet}"
    # Use the access token to post my status, Note that POSTing requires read/write access to the app and user
    update_hash = {'status' => tweet}
    access_token = prepare_access_token(row[1], row[2], row[3], row[4])

    response = access_token.post('https://api.twitter.com/1.1/statuses/update.json', update_hash, { 'Accept' => 'application/xml' })

    msg = "test"
    unless response.to_s =~ /.*HTTPOK/
      msg = ">>>>>>>>>>>>>>> #{Time.now.strftime('%Y-%m-%d@%H:%M:%S')} (#{uniq}) Twitter Tweet Non 200 Response for #{st} is #{response.to_s}\n"
      msg += ">>>>>>>>>>>>>>> (#{uniq}) response.body = #{response.body}\n" unless response.body.blank?
      TwitterMessage.create(message: msg)
    end

  end

  finish = Time.now
  Rails.logger.info ">>>>> #{finish.strftime('%Y-%m-%d_%H:%M:%S')} (#{uniq}) daily_tweets finished - #{(finish-start).round.to_s} seconds."

end

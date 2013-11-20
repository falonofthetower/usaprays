require 'aws/s3'
require 'csv'
require 'oauth'

TITLE_ABBV = [
    # Legislators from http://publicservantsprayer.org/
    ['US Representative', '?'],
    ['Representative', '??'],
    ['US Senator', '???'],
    ['Senator', '????'],
    ['Assemblymember', '?????'],
    ['Delegate', '??????'],
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
    ['President of the United States', 'Pres'],
    ['Vice President of the United States', 'VP'],
    # Justices from Refinery
    ['Associate Justice', 'AJ'],
    ['Chief Justice of the United States', 'CJ']
]

desc "Tweet to all the states"
task :daily_tweets => [:environment] do

  def prepare_access_token(consumer_key, consumer_secret, oauth_token, oauth_token_secret)
    consumer = OAuth::Consumer.new(consumer_key, consumer_secret,
                                   { :site => "https://api.twitter.com", :scheme => :header })
    token_hash = { :oauth_token => oauth_token, :oauth_token_secret => oauth_token_secret }
    OAuth::AccessToken.from_hash(consumer, token_hash )
  end

  def last_name(name)
    # regex to find the last name of a person.
    # Comma followed by suffix (, Jr.) is ignored if present.
    name =~ /(\w*)\s*(,.*)*\z/
    $1
  end

  past_first_row = false
  CSV.foreach("twitter_states_credentials.csv") do |row|
    unless past_first_row
      past_first_row = true
      next
    end
    st=row[0].downcase
    @state = UsState.new(st)
    @leaders = LeaderSelector.for_day(@state, Date.today())

    tweet = 'http://pray1tim2.org/s/'+st+' Please pray for:'
    @leaders.each do |l|
      title = l.title || ''
      unless title.blank?
        TITLE_ABBV.each do | title__abbv |
          if title.index(title__abbv[0])
            title = title__abbv[1]
            next
          end
        end
      end
      tweet += ' ' + title unless title.blank?
      tweet += ' ' + last_name(l.name)
    end

    puts tweet

    # Use the access token to post my status, Note that POSTing requires read/write access to the app and user
    #update_hash = {'status' => tweet}
    #access_token = prepare_access_token(row[1], row[2], row[3], row[4])
    #response = access_token.post('https://api.twitter.com/1.1/statuses/update.json', update_hash, { 'Accept' => 'application/xml' })

    #unless response == '200'
    #  msg = Time.now.to_s + " Response for #{st} is #{response.inspect}"
    #  `echo #{msg} >> twitter_states_credentials.msg`
    #end

  end

end



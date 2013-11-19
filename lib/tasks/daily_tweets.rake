require 'aws/s3'
require 'csv'

desc "Tweet to all the states"
task :daily_tweets => [:environment] do

  # This uses twitter @testdudette which uses a8144@hotmail.com, password = pw123pw
  #CONSUMER_KEY = "i0xhsUkBDewLZGjS6yKIuQ"
  #CONSUMER_SECRET = "xgEze98O6FGNdyPbby2SatrWVYFpdwXQAHO0F9VB0"
  #ACCESS_TOKEN = "2153294598-UVVa97lBxLUbZm2aVGYEG2vigUY3QQ2ktuDWyaf"
  #ACCESS_TOKEN_SECRET = "zkvPwssHuoZ9XwGwyRKtiXwumzJ7g3Q80N8T50DWrBiTv"

  require 'oauth'

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
    @date = Date.today()
    @leaders = LeaderSelector.for_day(@state, @date)

    tweet = 'http://pray1tim2.org/s/'+st+' Please pray for:'
    @leaders.each do |l|
      title = l.title

      tweet += ' '+title+' '+last_name(l.name)  #{l.name}) >> #{l.title}" }
    end

    # Use the access token to post my status, Note that POSTing requires read/write access to the app and user
    update_hash = {'status' => tweet}

    access_token = prepare_access_token(row[1], row[2], row[3], row[4])
    response = access_token.post('https://api.twitter.com/1.1/statuses/update.json', update_hash, { 'Accept' => 'application/xml' })

    unless response == '200'
      msg = Time.now.to_s + " Response for #{st} is #{response.inspect}"
      `echo #{msg} >> twitter_states_credentials.msg`
    end

  end

end

=begin

President of the United States = Pres
Vice President of the United States = VP
Governor of \a+ = Gov
Lt. Governor = LtGov
XX Secretary of State = SOS


Chief Justice of Supreme Court = CJus
Justice of Suprement Court = Jus


=end

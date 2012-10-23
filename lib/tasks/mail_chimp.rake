namespace :mail_chimp do

  task :set_up_segments => :environment do
    UsState.new.names.each do |code, name|
      state = UsState.new(code)
      MailListSegment.new(state, 'daily').create
      MailListSegment.new(state, 'weekly').create
    end
  end
end

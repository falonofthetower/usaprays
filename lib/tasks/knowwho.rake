namespace :knowwho do
  PERMITTED = %w[uid legalname firstname lastname prefix photofile statecode district spouse website twitter email facebook webform chamber legtype birthyear birthmonth birthdate residence district].freeze

  desc "TODO"
  task :import => :environment do
    files = []
    files << File.open("#{Rails.root.to_s}/knowwho/StateMembers.csv")
    files << File.open("#{Rails.root.to_s}/knowwho/FederalMembers.csv")
    files.each do |contents|
      CSV.foreach(contents, headers: true, encoding:'iso-8859-1:utf-8') do |leader|
        rehash = {}
        leader.to_hash.each_pair do |k,v|
          rehash.merge!({k.downcase => v}) if PERMITTED.include?(k.downcase)
        end
        leader = Leader.create(rehash)
        slug = Slugifier.construct(leader.title, leader.chamber, leader.firstname, leader.lastname, leader.statecode)
        Slug.create(know_who_id: leader.uid, path: slug)
      end
    end
  end
end

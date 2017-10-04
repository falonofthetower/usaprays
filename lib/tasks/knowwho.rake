require 'net/ftp'
require 'zip'
require 'securerandom'

namespace :knowwho do
  PERMITTED = %w[uid legalname firstname lastname prefix photofile statecode district spouse website twitter email facebook webform chamber legtype birthyear birthmonth birthdate residence district].freeze

  desc "TODO"
  task :import => :environment do
    files = []
    file_names = []
    destination = "#{Rails.root.to_s}/tmp/"
    Net::FTP.open(ENV['KWHOST'], ENV['KWUSERNAME'], ENV['KWPASSWORD']) do |ftp|
      ftp.passive = true
      ftp.nlst('*csv*.zip').each do |file_name|
        ftp.getbinaryfile(file_name, "#{destination}#{file_name}")
        file_names << "#{destination}#{file_name}"
      end
    end
    file_names.each do |file_name|
      Zip::File.open(file_name) do |zip_file|
        zip_file.glob('**/*Members.csv').each_with_index do |file|
          extracted_file_path = "#{destination}#{file.name.gsub('/',"#{SecureRandom.hex}")}"
          files << zip_file.extract(file, extracted_file_path)
        end
      end
    end
    files = Dir.glob('tmp/*.csv')
    files.each do |file_path|
      File.open(file_path) do |contents|
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
end

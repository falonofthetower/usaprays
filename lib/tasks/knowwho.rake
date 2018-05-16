require 'net/ftp'
require 'zip'
require 'securerandom'

def send_email(email)
  RestClient.post api_url+"/messages",
    :from => "peterskarth@gmail.com",
    :to => "peterskarth@gmail.com",
    :subject => "Import #{Time.now}",
    :text => email
end

namespace :knowwho do
  PERMITTED = %w[uid legalname firstname lastname prefix photofile statecode district spouse website twitter email facebook webform chamber legtype birthyear birthmonth birthdate residence district].freeze

  desc "TODO"
  task :import => :environment do
    email = ""
    timestamp = DateTime.current

    files = []
    file_names = []
    photo_zip_files = []
    destination = "#{Rails.root.to_s}/tmp/"
    # photo_destination = "#{Rails.root.to_s}/app/assets/images/"

    Dir.foreach(destination) {|f| File.delete("#{destination}#{f}") if f.split(".")[-1] == "csv"}
    Dir.foreach(destination) {|f| File.delete("#{destination}#{f}") if f.split(".")[-1] == "zip"}

    Net::FTP.open(ENV['KWHOST'], ENV['KWUSERNAME'], ENV['KWPASSWORD']) do |ftp|
      ftp.passive = true
      ftp.nlst('*csv*.zip').each do |file_name|
        if KnowwhoFile.find_by_name(file_name)
          email << ("File #{file_name} already seen")
          next
        else
          email << "File #{file_name} being processed"
        end
        ftp.getbinaryfile(file_name, "#{destination}#{file_name}")
        file_names << "#{destination}#{file_name}"
      end
      ftp.nlst('*photos*.zip').each do |file_name|
        if KnowwhoFile.find_by_name(file_name)
          email << "File #{file_name} already seen"
          next
        else
          email << "File #{file_name} being processed"
        end
        ftp.getbinaryfile(file_name, "#{destination}#{file_name}")
        photo_zip_files << "#{destination}#{file_name}"
        send_email(email)
      end
    end
    photo_zip_files.each do |file_name|
      Zip::File.open(file_name) do |zip_file|
        zip_file.each do |f|
          filename = f.name.downcase
          fpath = File.join(destination, filename)
          zip_file.extract(f, fpath) unless File.exist?(fpath)
          Dir.chdir(destination) do
            uploader = S3FolderUpload.new(filename.chomp("/"), ENV['S3_BUCKET'], ENV['S3_KEY'], ENV['S3_SECRET'])
            uploader.upload!
          end
        end
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
    uids = []
    files = Dir.glob('tmp/*.csv')
    files.each do |file_path|
      File.open(file_path) do |contents|
        CSV.foreach(contents, headers: true, encoding:'iso-8859-1:utf-8') do |leader|
          rehash = {"import_timestamp" => timestamp}
          leader.to_hash.each_pair do |k,v|
            rehash.merge!({k.downcase => v}) if PERMITTED.include?(k.downcase)
          end
          uid = rehash["uid"]
          leader = Leader.create(rehash)
          # leader = Leader.where(uid: uid).first_or_create
          # leader.update_attributes!(rehash)
          uids << uid

          slug = Slugifier.construct(leader.title, leader.chamber, leader.firstname, leader.lastname, leader.statecode)
          Slug.create(know_who_id: leader.uid, path: slug)
        end
      end
    end

    file_names.each do |file_name|
      KnowwhoFile.create!(name: file_name.split('/')[-1])
    end

    photo_zip_files.each do |file_name|
      KnowwhoFile.create!(name: file_name.split('/')[-1])
    end

    if uids.count > 7000
      ImportRecord.create!(
        timestamp: timestamp,
        leader_count: uids.count,
      )
    end
    Dir.foreach(destination) {|f| File.delete("#{destination}#{f}") if f.split(".")[-1] == "csv"}
    Dir.foreach(destination) {|f| File.delete("#{destination}#{f}") if f.split(".")[-1] == "zip"}
  end
end

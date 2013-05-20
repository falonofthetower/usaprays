require 'aws/s3'

desc "Backup of database and images to Amazon S3"
task :backup => [:environment] do

  AWS::S3::Base.establish_connection!(:access_key_id => 'AKIAIJJ2DUWDFU3P4GKA',:secret_access_key => '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')
  bucket = 'pray1tim2-backups'

  datestamp = Time.now.strftime("%Y-%m-%d_%H-%M-%S")

  #Use pg_dump to save the database, zip it up, an store it into in the /tmp/ directory
  pg_backup_file = "/tmp/usaprays_production_#{datestamp}_pg_dump.sql.gz"
  #dump the backup and zip it up
  sh "sudo -u postgres pg_dump usaprays_production | gzip -c > #{pg_backup_file}"
  #Move the zippped backup to amazon S3 bucket
  AWS::S3::S3Object.store(File.basename(pg_backup_file), File.open(pg_backup_file), bucket)
  File.delete pg_backup_file  #remove the /tmp/ file on completion

  #Zip up the Refinery images directories, store in /tmp/ directory
  img_backup_file = "/tmp/usaprays_production_#{datestamp}_images.gz"
  sh "tar -czf #{img_backup_file} /home/deployer/apps/usaprays/shared/system/refinery"
  AWS::S3::S3Object.store(File.basename(img_backup_file), File.open(img_backup_file), bucket)
  File.delete img_backup_file  #remove the /tmp/ file on completion

  #Discard all files in the s3 bucket for backups that are older than x days
  AWS::S3::Bucket.find(bucket).each do |bf|
    bf.delete if Time.parse(bf.about['last-modified']) < (Time.now - 120.days)
  end

end

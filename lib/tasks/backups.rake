require 'aws/s3'

desc "Backup of database and images to Amazon S3"
task :backup => [:environment] do
  datestamp = Time.now.strftime("%Y-%m-%d_%H-%M-%S")

  #Use pg_dump to save the database, zip it up, an store it into in the /tmp/ directory
  pg_backup_file = "/tmp/usaprays_production_#{datestamp}_pg_dump.sql.gz"
  #dump the backup and zip it up
  sh "sudo -u postgres pg_dump usaprays_production | gzip -c > #{pg_backup_file}"
  #Move the zippped backup to amazon S3 bucket
  send_to_amazon pg_backup_file, "pray1tim2-backups"
  File.delete pg_backup_file  #remove the /tmp/ file on completion

  #Zip up the Refinery images directories, store in /tmp/ directory
  img_backup_file = "/tmp/usaprays_production_#{datestamp}_images.gz"
  sh "tar cvzf #{img_backup_file} /home/deployer/apps/usaprays/shared/system/refinery/"
  send_to_amazon img_backup_file, "pray1tim2-backups"
  File.delete img_backup_file  #remove the /tmp/ file on completion

end

def send_to_amazon(file_path, bucket)
  file_name = File.basename(file_path)
  AWS::S3::Base.establish_connection!(:access_key_id => 'AKIAIJJ2DUWDFU3P4GKA',:secret_access_key => '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')
  AWS::S3::S3Object.store(file_name,File.open(file_path),bucket)
end

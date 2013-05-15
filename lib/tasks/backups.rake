require 'aws/s3'

desc "Backup of database and images to Amazon S3"
task :backup => [:environment] do
  #stamp the time

  datestamp = Time.now.strftime("%Y-%m-%d_%H-%M-%S")

  #drop it in the tmp directory
  backup_file = "/tmp/usaprays_production_#{datestamp}_dump.sql.gz"

  #dump the backup and zip it up
  #sh "pg_dump -h localhost -U #{env_config['username']} super_whammadyne | gzip -c > #{backup_file}"
  sh "sudo -u postgres pg_dump usaprays_production | gzip -c > #{backup_file}"

  send_to_amazon backup_file, "pray1tim2-backups-database"

  File.delete backup_file  #remove the file on completion so we don't clog up our app

end

def send_to_amazon(file_path, bucket)
  file_name = File.basename(file_path)
  AWS::S3::Base.establish_connection!(:access_key_id => 'AKIAIJJ2DUWDFU3P4GKA',:secret_access_key => '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')
  AWS::S3::S3Object.store(file_name,File.open(file_path,bucket))
end

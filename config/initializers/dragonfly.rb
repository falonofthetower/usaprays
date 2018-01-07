require 'dragonfly'

app = Dragonfly[:images]
app.datastore = Dragonfly::DataStorage::S3DataStore.new({
  :bucket_name        => ENV['BUCKETEER_AWS_BUCKET_NAME'],
  :access_key_id      => ENV['BUCKETEER_AWS_ACCESS_KEY_ID'],
  :secret_access_key  => ENV['BUCKETEER_AWS_SECRET_ACCESS_KEY']
})

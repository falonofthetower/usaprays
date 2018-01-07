require 'dragonfly'

app = Dragonfly[:images]
app.datastore = Dragonfly::DataStorage::S3DataStore.new({
  :bucket_name        => ENV['S3_BUCKET'],
  :access_key_id      => ENV['S3_KEY'],
  :secret_access_key  => ENV['S3_SECRET']
})

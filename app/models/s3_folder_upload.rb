class S3FolderUpload
  attr_reader :folder_path, :total_files, :s3_bucket, :include_folder
  attr_accessor :files

  # Initialize the upload class
  #
  # folder_path - path to the folder that you want to upload
  # bucket - The bucket you want to upload to
  # aws_key - Your key generated by AWS defaults to the environemt setting AWS_KEY_ID
  # aws_secret - The secret generated by AWS
  # include_folder - include the root folder on the path? (default: true)
  #
  # Examples
  #   => uploader = S3FolderUpload.new("some_route/test_folder", 'your_bucket_name')
  #
  def initialize(folder_path, bucket, aws_key = ENV['AWS_KEY_ID'], aws_secret = ENV['AWS_SECRET'], include_folder = true)
    Aws.config.update({
      region: 'us-east-1',
      credentials: Aws::Credentials.new(aws_key, aws_secret)
    })

    @folder_path       = folder_path
    @files             = Dir.glob("#{folder_path}/**/*")
    @total_files       = files.length
    @connection        = Aws::S3::Resource.new
    @s3_bucket         = @connection.bucket(bucket)
    @include_folder    = include_folder
  end

  # public: Upload files from the folder to S3
  #
  # thread_count - How many threads you want to use (defaults to 5)
  # simulate - Don't perform upload, just simulate it (default: false)
  # verbose - Verbose info (default: false)  
  #
  # Examples
  #   => uploader.upload!(20)
  #     true
  #   => uploader.upload!
  #     true
  #
  # Returns true when finished the process
  def upload!(thread_count = 5, simulate = false, verbose = false)
    file_number = 0
    mutex       = Mutex.new
    threads     = []

    puts "Total files: #{total_files}... uploading (folder #{folder_path} #{include_folder ? '' : 'not '}included)"

    thread_count.times do |i|
      threads[i] = Thread.new {
        until files.empty?
          mutex.synchronize do
            file_number += 1
            Thread.current["file_number"] = file_number
          end
          file = files.pop rescue nil
          next unless file

          # Define destination path
          if include_folder
            path = file
          else
            path = file.sub(/^#{folder_path}\//, '')
          end

          puts "[#{Thread.current["file_number"]}/#{total_files}] uploading..." if verbose

          data = File.open(file)

          unless File.directory?(data) || simulate
            obj = s3_bucket.object(path)
            obj.put({ acl: 'public-read', body: data })
          end

          data.close
        end
      }
    end
    threads.each { |t| t.join }
  end
end

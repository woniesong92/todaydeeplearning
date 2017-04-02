CarrierWave.configure do |config|
  if Rails.env.development? || Rails.env.test?
    config.storage = :file
  else
    config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     ENV['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      region:                ENV['AWS_BUCKET_REGION']
    }
    config.fog_directory = ENV['AWS_BUCKET_NAME']
    config.storage = :fog
    # config.asset_host = ENV['CDN_ORIGIN']
  end
end

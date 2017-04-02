desc "This task is called by the Heroku scheduler add-on"
task :fetch_and_store_papers => :environment do
  p "Start fetching Arvix papers..."
  ArvixPaperFetchingJob.perform_later(2)
end

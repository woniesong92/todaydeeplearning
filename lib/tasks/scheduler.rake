namespace :scheduler do
  desc "This task is called by the Heroku scheduler add-on"
  task :fetch_and_store_papers => :environment do
    ArvixPaperFetchingJob.perform_later
  end
end

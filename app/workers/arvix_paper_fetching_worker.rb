# Fetch Arvix papers everyday
# TODO: setup a cron job

class ArvixPaperFetchingWorker
  include Sidekiq::Worker

  def perform
    raw_papers = ArvixGetter.new(max_results: 10).papers
    hashed = Hash.from_xml(raw_papers)
    entries = hashed["feed"]["entry"]

    entries.each do |entry|
      ArvixPaper::Create.new(entry).call
    end
  end
end

namespace :arvix_papers do
  desc "Fetch and save latest papers from Arvix"
  task :populate_with_latest_papers => :environment do
    raw_papers = ArvixGetter.new(max_results: 3).papers
    hashed = Hash.from_xml(raw_papers)
    entries = hashed["feed"]["entry"]

    entries.each do |entry|
      ArvixPaper::Create.new(entry).call
    end
  end
end

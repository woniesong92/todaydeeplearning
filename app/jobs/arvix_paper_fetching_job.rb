class ArvixPaperFetchingJob < ApplicationJob
  queue_as :default

  def perform(num_papers_to_fetch=50)
    categories = ['cs.CV', 'cs.CL', 'cs.LG', 'cs.AI', 'cs.NE', 'stat.ML']
    categories.each do |cat|
      # Assuming there are ~50 papers/day/category
      raw_papers = ArvixGetter.new(max_results: num_papers_to_fetch, cat: cat).papers
      hashed = Hash.from_xml(raw_papers)
      entries = hashed["feed"]["entry"]

      entries.each do |entry|
        ArvixPaper::Create.new(entry).call
      end
    end
  end
end

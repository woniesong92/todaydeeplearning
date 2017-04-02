def populate_with_real_papers(max_results=5)
  raw_papers = ArvixGetter.new(max_results: max_results).papers
  hashed = Hash.from_xml(raw_papers)
  entries = hashed["feed"]["entry"]

  entries.each do |entry|
    ArvixPaper::Create.new(entry).call
  end
end

# This will download 3 latest arvix papers from cs.AI category
populate_with_real_papers(3)

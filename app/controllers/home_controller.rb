class HomeController < ApplicationController
  def index
    raw_papers = ArvixGetter.new().papers
    hashed = Hash.from_xml(raw_papers)
    entries = hashed["feed"]["entry"]
    # entry = entries[0]

    # NOTE: this will be in a bg job
    entries.each do |entry|
      ArvixPaper::Create.new(entry).call
    end
  end
end

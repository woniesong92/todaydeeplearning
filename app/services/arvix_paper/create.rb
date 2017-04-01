class ArvixPaper::Create
  def initialize(entry)
    @entry = entry
  end

  def call
    arvix_paper_params = ArvixParser.new(@entry).parse
    author_names = ArvixParser.new(@entry).author_names
    arvix_paper = ArvixPaper.create(arvix_paper_params)
    if arvix_paper.persisted?
      author_names.each do |author_name|
        author = Author.find_or_create_by(name: author_name)
        author.arvix_papers << arvix_paper
      end
    end
  end
end

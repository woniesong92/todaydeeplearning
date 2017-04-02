class ArvixPaper::Create
  def initialize(entry)
    @entry = entry
  end

  def call
    arvix_paper_params = ArvixParser.new(@entry).parse

    if arvix_paper_params && !already_stored?(arvix_paper_params[:title])
      author_names = ArvixParser.new(@entry).author_names
      arvix_paper = ArvixPaper.create(arvix_paper_params)

      if arvix_paper.persisted?
        author_names.each do |author_name|
          author = Author.find_or_create_by(name: author_name)
          author.arvix_papers << arvix_paper
        end

        upload_thumbnail(arvix_paper)
      end
    end
  end

  private

  def upload_thumbnail(arvix_paper)
    thumbnail_path = ArvixPaper::PdfToThumb.new(arvix_paper[:pdf_link]).call
    arvix_paper.thumbnail = File.open(thumbnail_path)
    arvix_paper.save!
  end

  def already_stored?(title)
    ArvixPaper.find_by(title: title).present?
  end
end

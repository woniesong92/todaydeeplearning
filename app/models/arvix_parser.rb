class ArvixParser
  def initialize(entry)
    @entry = entry
  end

  def parse
    return {} unless @entry

    parsed = {
      title: @entry['title'],
      category: @entry['primary_category']["term"],
      summary: @entry['summary'],
      comment: @entry['comment'],
      paper_link: @entry['link'].find { |l| l['type'] == 'text/html' }['href'],
      pdf_link: @entry['link'].find { |l| l['type'] == 'application/pdf' }['href'],
      published_date: DateTime.parse(@entry['published']),
      paper_updated_at: DateTime.parse(@entry['updated']),
      raw_data: @entry
    }
    
    parsed
  end
end

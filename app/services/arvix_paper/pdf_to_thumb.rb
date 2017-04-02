class ArvixPaper::PdfToThumb
  def initialize(pdf_url, num_thumb_pages=3)
    @pdf_url = pdf_url.ends_with?('.pdf') ? pdf_url : pdf_url + '.pdf'
    @num_thumb_pages = num_thumb_pages
  end

  def call
    downloaded_pdf = HTTParty.get(
      @pdf_url,
      headers: {"User-Agent" => 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36'}
    ).body
    tmp_file_path = Dir::Tmpname.make_tmpname '/tmp/', nil

    File.open(tmp_file_path+'.pdf', "wb") do |f|
      f.write(downloaded_pdf)
    end

    generate_thumb(tmp_file_path)
  end

  private

  # 1. Grab first few pages of pdf and split them into jpgs
  # 2. Montage them side by side (e.g. 1x-title)
  # Returns a tmp path to the generated thumbnail file
  def generate_thumb(tmp_file_path)
    %x(magick convert #{tmp_file_path}.pdf[0-#{@num_thumb_pages}] -thumbnail x640 #{tmp_file_path}.jpg)
    stripped_file_names = (0...@num_thumb_pages).to_a.map { |i| "#{tmp_file_path}-#{i}.jpg" }.join(" ")
    %x(magick montage #{stripped_file_names} -mode concatenate -quality 80 -tile x1 #{tmp_file_path}_merged.jpg)

    "#{tmp_file_path}_merged.jpg"
  end
end

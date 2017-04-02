class AddThumbnailToArvixPapers < ActiveRecord::Migration[5.0]
  def change
    add_column :arvix_papers, :thumbnail, :string
  end
end

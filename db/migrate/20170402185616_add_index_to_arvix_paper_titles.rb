class AddIndexToArvixPaperTitles < ActiveRecord::Migration[5.0]
  def change
    add_index :arvix_papers, :title
  end
end

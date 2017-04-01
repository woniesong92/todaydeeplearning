class CreateAuthorPaperConnections < ActiveRecord::Migration[5.0]
  def change
    create_table :author_paper_connections do |t|
      t.references :author, foreign_key: true
      t.references :arvix_paper, foreign_key: true

      t.timestamps
    end
  end
end

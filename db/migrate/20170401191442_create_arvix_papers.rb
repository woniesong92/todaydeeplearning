class CreateArvixPapers < ActiveRecord::Migration[5.0]
  def change
    create_table :arvix_papers do |t|
      t.datetime :paper_updated_at
      t.datetime :published_date
      t.string :title, null: false
      t.text :summary
      t.text :comment
      t.string :paper_link
      t.string :pdf_link
      t.string :category, null: false
      t.jsonb :raw_data

      t.timestamps
    end
  end
end

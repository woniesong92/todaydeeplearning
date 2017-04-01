class Author < ApplicationRecord
  has_many :author_paper_connections, dependent: :destroy
  has_many :arvix_papers, through: :author_paper_connections
end

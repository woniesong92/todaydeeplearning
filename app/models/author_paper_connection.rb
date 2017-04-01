class AuthorPaperConnection < ApplicationRecord
  belongs_to :author
  belongs_to :arvix_paper
end

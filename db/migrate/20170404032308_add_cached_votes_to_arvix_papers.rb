class AddCachedVotesToArvixPapers < ActiveRecord::Migration[5.0]
  def change
    add_column :arvix_papers, :cached_votes_total, :integer, default: 0, index: true
    add_column :arvix_papers, :cached_votes_score, :integer, default: 0, index: true
    add_column :arvix_papers, :cached_votes_up, :integer, default: 0, index: true
    add_column :arvix_papers, :cached_votes_down, :integer, default: 0, index: true

    ArvixPaper.find_each(&:update_cached_votes)
  end
end

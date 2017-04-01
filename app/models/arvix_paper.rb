class ArvixPaper < ApplicationRecord
  acts_as_votable

  scope :today, -> { where(created_at: 1.day.ago..DateTime.now).order(created_at: :desc).limit(200) }
  scope :this_week, -> { where(created_at: 1.week.ago..DateTime.now).order(created_at: :desc).limit(200) }
  scope :this_month, -> { where(created_at: 1.month.ago..DateTime.now).order(created_at: :desc).limit(200) }

  class << self
    def sort_by_rank(papers)
      papers.sort { |a,b| compare(a, b) }
    end

    private

    # HN ranking algorithm
    # P = points of an item (and -1 is to negate submitters vote)
    # T = time since submission (in hours)
    # G = Gravity, defaults to 1.8 in news.arc
    # Score = (P-1) / (T+2)^G
    def compare(paper_a, paper_b)
      paper_score(paper_b) <=> paper_score(paper_a)
    end

    def paper_score(paper)
      points = paper.get_likes.size
      time_since_submission = (Time.now - paper.created_at) / 3600
      (points - 1) / (time_since_submission + 2) ** 1.8
    end
  end
end

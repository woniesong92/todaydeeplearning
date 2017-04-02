class ArvixPaper < ApplicationRecord
  acts_as_votable

  mount_uploader :thumbnail, ArvixPaperThumbnailUploader

  has_many :author_paper_connections, dependent: :destroy
  has_many :authors, through: :author_paper_connections

  scope :within, -> (period, category) {
    case period
    when 'today'
      category ?
        where(category: category, created_at: 1.day.ago..DateTime.now).order(created_at: :desc).limit(200) :
        where(created_at: 1.day.ago..DateTime.now).order(created_at: :desc).limit(200)

    when 'this_week'
      category ?
        where(category: category, created_at: 1.week.ago..DateTime.now).order(created_at: :desc).limit(200) :
        where(created_at: 1.week.ago..DateTime.now).order(created_at: :desc).limit(200)
    when 'this_month'
      category ?
        where(category: category, created_at: 1.month.ago..DateTime.now).order(created_at: :desc).limit(200) :
        where(created_at: 1.month.ago..DateTime.now).order(created_at: :desc).limit(200)
    else
      category ?
        where(category: category, created_at: 1.month.ago..DateTime.now).order(created_at: :desc).limit(200) :
        where(created_at: 1.month.ago..DateTime.now).order(created_at: :desc).limit(200)
    end
  }

  def author_names
    self.authors.map { |author| author.name }
  end

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

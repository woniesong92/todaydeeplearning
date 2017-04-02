class ArvixPapersController < ApplicationController
  before_action :load_paper, only: [:show, :upvote, :downvote, :update]
  before_action :require_login, only: [:upvote, :downvote]

  def index
    papers = ArvixPaper.within(params[:period], params[:category])

    if params[:latest]
      @arvix_papers = papers.page(params[:page]).without_count
    else
      sorted_papers = ArvixPaper.sort_by_rank(papers)
      @arvix_papers = Kaminari.paginate_array(sorted_papers).page(params[:page]).per(10)
    end
  end

  def show
  end

  def upvote
    @arvix_paper.liked_by current_user
    redirect_to arvix_papers_path
  end

  def downvote
    @arvix_paper.downvote_from current_user
    redirect_to arvix_papers_path
  end

  private

  def load_paper
    @arvix_paper = ArvixPaper.find(params[:id])
  end
end

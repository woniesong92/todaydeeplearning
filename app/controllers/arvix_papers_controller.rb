class ArvixPapersController < ApplicationController
  before_action :load_paper, only: [:show, :upvote, :downvote, :update]
  before_action :require_login, only: [:upvote, :downvote]

  def index
    papers = ArvixPaper.within(params[:period], params[:category])
    @arvix_papers = params[:latest] ? papers : ArvixPaper.sort_by_rank(papers)
  end

  def show
  end

  def update
    permitted_params = params.require(:arvix_paper).permit!
    x = @arvix_paper.update(permitted_params)

    redirect_to arvix_paper_path(@arvix_paper)
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

class ArvixPapersController < ApplicationController
  before_action :load_paper, only: [:show, :upvote, :downvote]
  before_action :require_login, only: [:upvote, :downvote]

  def index
    @arvix_papers = ArvixPaper.all
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

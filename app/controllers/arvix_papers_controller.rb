class ArvixPapersController < ApplicationController
  def index
    @arvix_papers = ArvixPaper.all
  end

  def show
    load_paper
  end

  private

  def load_paper
    @arvix_paper = ArvixPaper.find(params[:id])
  end
end

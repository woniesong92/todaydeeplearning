class HomeController < ApplicationController
  def index
    ArvixGatherer.new().papers
  end
end

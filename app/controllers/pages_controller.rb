class PagesController < ApplicationController
  def show
    @page = Admin::Page.find_by_url params[:url]
  end

  def index
    render layout: false
  end
end

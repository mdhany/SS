class PagesController < ApplicationController
  def show
    @page = Admin::Page.find_by_url params[:url]
  end
end

class PagesController < ApplicationController
  def about
  end
  def home
    # render plain: 'Hello World!'
    # @page = Page.new
    @date_search = params[:q] ? params[:q] : "1994/05/10"
    @rising = params[:rising] ? params[:rising] : "Aries"
  end
end

class PagesController < ApplicationController
  def about
  end
  def home
    # render plain: 'Hello World!'
    # @page = Page.new
    # @date_search = params[:q] ? params[:q] : "1984/05/10"
    @date_search = params[:birth] && params[:birth] != "" ? params[:birth] : 
      params[:q] && params[:q] != "" ? params[:q].gsub('/','-') : "1980-09-22T23:54"
    @date_search += "T12:00" if !@date_search[/T/]
    @rising = params[:rising] ? params[:rising] : "Unknown"
    @time_zone = params[:time_zone] ? params[:time_zone] : "Sydney"
    utc_offset = @date_search.to_datetime.in_time_zone(@time_zone).strftime('%z')
    @utc = eval(utc_offset[0]+utc_offset[1..2]+'+'+(utc_offset[3..4].to_f/60).to_s)
  end
end

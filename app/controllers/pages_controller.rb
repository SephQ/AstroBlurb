class PagesController < ApplicationController
  def about
  end
  def home
    @date_search = params[:birth_time] && params[:birth_time] != "" ? params[:birth_time] : "1980-09-22T23:54"
    @rising = params[:rising] ? params[:rising] : "Unknown"
    @commit = params[:commit] ? true : false
    @time_zone = params[:time_zone] ? params[:time_zone] : "Sydney"
    utc_offset = @date_search.to_datetime.in_time_zone(@time_zone).strftime('%z')
    @utc = eval(utc_offset[0]+utc_offset[1..2]+'+'+(utc_offset[3..4].to_f/60).to_s) # Float from +0730 string format -> 7.5
    @julday = helpers.julday(@date_search)
    p params.to_enum.to_h, @rising, @julday # For debugging
  end
end

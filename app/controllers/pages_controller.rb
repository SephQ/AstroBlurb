class PagesController < ApplicationController
  def about
  end
  def home
    load_params
  end
  def roast
    load_params
  end
  def load_params
    # Check if the user has submitted parameters for an astrology blurb, convert them into named variables if so.
    @date_search = params[:birth_time] && params[:birth_time] != "" ? params[:birth_time] : "1980-09-22T23:54"
    @rising = params[:rising] ? params[:rising] : "Unknown"
    @commit = params[:commit] ? true : false
    @time_zone = params[:time_zone] ? params[:time_zone] : "Sydney"
    utc_offset = @date_search.to_datetime.in_time_zone(@time_zone).strftime('%z')
    @utc = eval(utc_offset[0]+utc_offset[1..2]+'+'+(utc_offset[3..4].to_f/60).to_s) # Float from +0730 string format -> 7.5
    @long = @time_zone == "Sydney" ? 151.2099 : @utc * 15   # Rough guess at longitude based on timezone
    @lat = -33.8651   # Sydney assumed for now, hard to solve this from timezone.
    @julday = helpers.julday(@date_search)
    p params.to_enum.to_h, @rising, @julday, '<r,jd|lat,lon>', @lat, @long # For debugging
  end
end

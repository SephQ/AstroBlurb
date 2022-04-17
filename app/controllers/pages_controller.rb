class PagesController < ApplicationController
  def about
  end
  def home
    load_params
  end
  def roast
    load_params
  end
  def reading
    load_params
    load_readings
  end
  def quiz
    # Test your ability to recognize your own astrology reading from a false control.
    # Uses more obscure readings and doesn't tell you which planet is being tested (optional?).
  end
  def load_params
    # Check if the user has submitted parameters for an astrology blurb, convert them into named variables if so.
    @date_search = params[:birth_time] && params[:birth_time] != "" ? params[:birth_time] : "1980-09-22T23:54"
    @rising = params[:rising] ? params[:rising] : "Unknown"
    @commit = params[:commit] ? true : false
    @birth_city = params[:birth_city] ? params[:birth_city] : "Sydney, Australia"
    # @time_zone = params[:time_zone] ? params[:time_zone] : "Sydney"
    # utc_offset = @date_search.to_datetime.in_time_zone(@time_zone).strftime('%z')
    # @utc = eval(utc_offset[0]+utc_offset[1..2].to_i.to_s+utc_offset[0]+(utc_offset[3..4].to_f/60).to_s) # Float from +0730 string format -> 7.5
    # @long = @time_zone == "Sydney" ? 151.2099 : @utc * 15   # Rough guess at longitude based on timezone
    p 'request ip, remote', [request.ip, request.remote_ip],[Geocoder.search(request.ip),Geocoder.search(request.remote_ip)]
    results = Geocoder.search(@birth_city)  # https://www.abstractapi.com/guides/how-to-get-an-ip-address-using-ruby-on-rails
    @birth_city = results.first.address.gsub(/, .+(?=,.*,.*,)/,'') || @birth_city
    p 'results    v   ',results.first
    # @lat = -33.8651   # Sydney assumed for now, hard to solve this from timezone.
    @lat, @long =  results.empty? ? [-33.8651,151.2093] : results.first.coordinates.map(&:to_f) # https://github.com/alexreisner/geocoder
    # @time_zone = Timezone::Zone.new :latlon => [@lat, @long]
    # @time_zone = TZInfo::Timezone.get("Australia/Sydney")
    @time_zone = Timezone.lookup(@lat, @long)
    # @julday = helpers.julday(@date_search)
    date = DateTime.parse(@date_search)
    date_shifted = @time_zone.local_to_utc( date.to_time )
    p 'date, shifted, %FT%T', date, date_shifted, date_shifted.strftime("%FT%T")
    @julday = helpers.julday( date_shifted.strftime("%FT%T") )
    p params.to_enum.to_h, @rising, @julday, '<r,jd|lat,lon>', @lat, @long # For debugging
  end
  def load_readings
    @primal_desc = File.read('app/lib/primalastrology.txt').split("\n")
    @primal_names = File.read('app/lib/primalnames.txt').split("\n")
    @sun_moon_desc = File.read('app/lib/sunmoon.txt').split("\n")
    @rising_desc = File.read('app/lib/rising.txt').split("\n")
    @mars_desc = File.read('app/lib/mars.txt').split("\n")
    @venus_desc = File.read('app/lib/venus.txt').split("\n")
    @numerology_desc = File.read('app/lib/numerology.txt').split("\n")
    @pluto_desc = File.read('app/lib/pluto.txt').split("\n")
    @nn_desc = File.read('app/lib/northnode.txt').split("\n")
  end
end

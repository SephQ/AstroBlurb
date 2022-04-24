class ApplicationController < ActionController::Base
  # Copied some functions to application controller so blurbs can use them too. ('lon2sign' etc), need to DRY it up later
  def load_params
    # Check if the user has submitted parameters for an astrology blurb, convert them into named variables if so.
    @date_search = params[:birth_time] && params[:birth_time] != "" ? params[:birth_time] : 
      (Time.now-27.years).strftime("%Y-%m-%dT12:00") # e.g. "1994-04-24T12:00" (changes to match midday 28 years ago unless the user has submitted their birthday)
    @rising = params[:rising] ? params[:rising] : "Unknown"
    @commit = params[:commit] ? true : false
    @birth_city = params[:birth_city] ? params[:birth_city] : "Sydney, Australia"
    # @time_zone = params[:time_zone] ? params[:time_zone] : "Sydney"
    # utc_offset = @date_search.to_datetime.in_time_zone(@time_zone).strftime('%z')
    # @utc = eval(utc_offset[0]+utc_offset[1..2].to_i.to_s+utc_offset[0]+(utc_offset[3..4].to_f/60).to_s) # Float from +0730 string format -> 7.5
    # @long = @time_zone == "Sydney" ? 151.2099 : @utc * 15   # Rough guess at longitude based on timezone
    p 'request ip, remote', [request.ip, request.remote_ip],[Geocoder.search(request.ip),Geocoder.search(request.remote_ip)]
    results = Geocoder.search(@birth_city)  # https://www.abstractapi.com/guides/how-to-get-an-ip-address-using-ruby-on-rails
    @birth_city = results.first&.address&.gsub(/, .+(?=,.*,.*,)/,'') || "City not found"
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
    Swe4r::swe_set_ephe_path('lib')          # Initialize Swiss Ephemeris
    p ['lat,long,,swesettop',@lat,@long] #, Swe4r::swe_set_topo(@lat, @long, 100)
    Swe4r::swe_set_topo(@lat, @long, 100) # Set the topocentric location with 100 m altitude above sea level (planets positions relative to your location on the Earth surface)
    if @rising == "Unknown" && params[:commit] #params[:time_zone] && params[:birth_time]
      # User didn't know their rising sign but submitted a form, calculate it for them
      @rising = rising_sign( @julday, @lat, @long )
      p @julday, '<jd rsign>', @rising, swe_houses(@julday,@lat, @long)[1]
    end
  end
  def load_readings
    @primal_desc = File.read('app/lib/primalastrology.txt').split("\n")
    @primal_names = File.read('app/lib/primalnames.txt').split("\n")
    @sun_moon_desc = File.read('app/lib/sunmoon.txt').split("\n")
    # Neutralise the gendered 'he/him' pronouns in the rising description before splitting. Fix capitalization if broken.
    @rising_desc = neutralise_him( File.read('app/lib/rising.txt') ).split("\n")
    @mars_desc = File.read('app/lib/mars.txt').split("\n")
    @venus_desc = File.read('app/lib/venus.txt').split("\n")
    @numerology_desc = File.read('app/lib/numerology.txt').split("\n")
    @pluto_desc = File.read('app/lib/pluto.txt').split("\n")
    @nn_desc = File.read('app/lib/northnode.txt').split("\n")
  end
  def neutralise_him( himput )
    # Translate gendered (he/him/his) language to gender neutral for readings (they/them/their).
    himput = himput.gsub(/\bhe is\b/i, '[they are]').gsub(/\bhe (\w+)(?<!s)s\b/i, '[they \1]').
      gsub(/\bhe\b/i, '[they]').gsub(/\bhis\b(?! )/i, '[theirs]').gsub(/\bhis\b/i, '[their]').gsub(/\bhim\b/i, '[them]')
    # Fix any broken grammar rules, including capitalisation
    himput.gsub(/\. \[t/,'. [T')
  end
  def swe_houses(julian_day, lat, long, hsys='Placidus'[0].ord)
    Swe4r::swe_houses(julian_day, lat, long, hsys)
  end
  def rising_sign(julian_day, lat, long)
    lon2sign( swe_houses(julian_day, lat, long)[1] )
  end
  def lon2sign(lon)
    # Convert ecliptic longitude values to zodiac signs
    %w[Aries Taurus Gemini Cancer Leo Virgo Libra Scorpio Sagittarius Capricorn Aquarius Pisces][ (lon/30).to_i ]
  end
end

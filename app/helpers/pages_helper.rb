module PagesHelper
  def permitted_params
    # List of permitted parameters for the params 'hash'. Saves writing it separately everywhere. (removed :controller)
    [:id, :title, :text, :planet_replacements, :format, :rising, :birth_time, :time_zone, :birth_city, :commit]
  end
  def lon2sign(lon)
    # Convert ecliptic longitude values to zodiac signs
    %w[Aries Taurus Gemini Cancer Leo Virgo Libra Scorpio Sagittarius Capricorn Aquarius Pisces][ (lon/30).to_i ]
  end
  def lon2num(lon)
    # Convert ecliptic longitude values to zodiac numbers Aries=0, Pisces=11.
    (lon/30).to_i
  end
  def blurbify(sun,moon,mercury,venus,mars,ascnum)  # was blurb() in the past, but changed now blurbs are objects 220423
    # Inputs are the ecliptic longitude values of each of the named planetary bodies
    text = ['I am ','',' but my emotions are rather ','','. I think in a ','',' way, but express my energy in a ','',' way. In love, I seek ','','. I take on the role of ','','.']
    # out = ["Sun in "+ra2sign(sun)+", Moon in "+ra2sign(moon)+", Mercury in "+ra2sign(mercury)+", Venus in "+ra2sign(venus)+" and Mars in "+ra2sign(mars)]
    plist = [lon2num(sun),lon2num(moon),lon2num(mercury),lon2num(mars),lon2num(venus),ascnum]
    blbans = [['an initiator','a guardian','a wanderer','a psychic','a warrior','a mastermind','a peacemaker','a detective','an explorer','an entrepreneur','a visionary','a dreamer'],
    ['intense','enduring','sparkling','deep','vibrant','composed','whimsical','overwhelming','vivid','guarded','unpredictable','extreme'],
    ['direct','practical','lighthearted','intuitive','dynamic','fruitful','artistical','complex','curious','purposeful','logical','vague'],
    ['combative','abiding','erratic','protective','powerful','efficient','passive','brooding','lively','focused','analytical','creative'],
    ['passion','commitment','stimulation','security','affection','respect','support','devotion','excitement','intensity','understanding','stability'],
    ['the pioneer','the owner','the messenger','the nurturer','the protector','the organizer','the aesthete','the mystic','the comedian','the old soul','the outlaw','the creator','the {...}']]
    (0..5).each do |i|
      planet = plist[i]
      text[i*2+1] = blbans[i][planet]
    end
    text.join.gsub(/(?<= a)(?= [aeiou])/,'n')
  end
  def roast(moon,sun,venus,mars)
    # Inputs are the ecliptic longitude values of each of the named planetary bodies
    text = "You're just a@@ @@ that feels like it's a@@ @@."
    plist = [lon2num(moon),lon2num(sun),lon2num(venus),lon2num(mars)]
    wlist = [ [' hyperactive',' relentless',' talkative',' loving',' dramatic',' dedicated',' charming','n intense','n adventurous',' hard-working','n erratic','n easy-going'],
      ['ram','bull','bee','hermit crab','lion','lamb','human','scorpion','stallion','goat','alien','carp'],
      [' passionate',' dependable',' popular','n empathic',' famous','n innocent',' posh',' pioneering',' ',' successful',' revolutionary',' tortured'],
      ['hero','bull','comedian','child','celebrity','martyr','expert','detective','philosopher','CEO','prophet','healer'] ]
    words = plist.zip(wlist).map{|i,j| j[i] }
    out = text.gsub(/@@/){ words.shift }   # Replace each '@@' in the text with the words from the word list in order.
    out.gsub(/(?<= a)(?= [aeiou])/,'n')
  end
  def zodlist
    %w[Aries Taurus Gemini Cancer Leo Virgo Libra Scorpio Sagittarius Capricorn Aquarius Pisces Unknown]
  end
  def sign2num( sign )
    zodlist.index( sign.capitalize )
  end
  def eastlist
    %w[Rat Ox Tiger Rabbit Dragon Snake Horse Goat Monkey Rooster Dog Pig Unknown]
  end
  def planetlist
    %w[sun moon mercury venus mars jupiter saturn uranus neptune pluto]
  end
  # If we gauge personality more literally than physically then gender can feel a lot less binary.
  def tz_hotlist
    # Some of the priority timezones
    ["Pacific Time (US & Canada)", "Eastern Time (US & Canada)", "Paris", "London", "Pretoria", "Melbourne", "Sydney", "Tokyo", "Beijing", "Seoul"]
  end
  def ymdhm(date)
    # Split a date into an array of year, month, day, hour and minute - for creating Time
    # Abandoned for now, lol
  end
  def swe_name(planet)
    # Rename generic planet names (e.g. 'sun', 'moon', 'lilith') to Swiss Ephemeris body names (https://www.astro.com/swisseph/swephprg.htm#_Toc471829059 under 3.2.  Bodies (int ipl))
    # sun, moon, mercury, venus, mars, jupiter, saturn, uranus, neptune, pluto, mean_node, true_node, mean_apog, oscu_apog, earth, chiron, pholus, ceres, pallas, juno, vesta
    allowed_names = %w[SUN MOON MERCURY VENUS MARS JUPITER SATURN URANUS NEPTUNE PLUTO NORTHNODE NORTH_NODE MEAN_NODE TRUE_NODE NODE LILITH TRUE_LILITH MEAN_LILITH MEAN_APOG OSCU_APOG EARTH CHIRON PHOLUS CERES PALLAS JUNO VESTA RISING]
    # %w[ECL_NUT SUN MOON MERCURY VENUS MARS JUPITER SATURN URANUS NEPTUNE PLUTO MEAN_NODE TRUE_NODE MEAN_APOG OSCU_APOG EARTH CHIRON PHOLUS CERES PALLAS JUNO VESTA INTP_APOG INTP_PERG NPLANETS FICT_OFFSET NFICT_ELEM PLMOON_OFFSET AST_OFFSET CUPIDO HADES ZEUS KRONOS APOLLON ADMETOS VULKANUS POSEIDON ISIS NIBIRU HARRINGTON NEPTUNE_LEVERRIER NEPTUNE_ADAMS PLUTO_LOWELL PLUTO_PICKERING].include?(planet)
    planet = planet.upcase  # First remove case-sensitivity issues
    if !allowed_names.include?(planet)
      return "se_rename error: #{ planet } is not a valid name."
    end
    # Replace allowed abbreviations with their true Swiss Ephemeris names and add "SE_" prefix
    if %w[NORTHNODE NORTH_NODE NODE].include?(planet)
      planet = "MEAN_NODE"  # Assume the mean north node Unless @true_node is used explicity
    elsif %w[LILITH MEAN_LILITH].include?(planet)
      planet = "MEAN_APOG"  # Assume the mean Lilith (Black Moon Lilith) Unless @true_lilith is used explicity
    elsif %w[TRUE_LILITH].include?(planet)
      planet = "OSCU_APOG"
    end
    if planet[/^Swe4r::SE_/]
      planet = eval(planet)
    else
      planet = eval("Swe4r::SE_" + planet)
    end
    planet          # Output the Swiss Ephemeris body object
  end
  def swe_calc_ut(julian_day, planet)
    Swe4r::swe_calc_ut(julian_day, swe_name(planet), Swe4r::SEFLG_SWIEPH)#|Swe4r::SEFLG_TOPOCTR - Swe4r::SEFLG_MOSEPH instead of SEFLG_SWIEPH
  end
  def swe_calc_sign(julian_day, planet)
    # Calculate the sign position of an input planet for the given birth time.
    lon2sign( swe_calc_ut(julian_day, planet)[0] )
  end
  def swe_calc_house(julian_day, planet)
    # Calculate the house position of an input planet for the given birth time. 1 = in the 1st house, 12 = in the 12th house
    # p "swe_calc_house(#{[julian_day, planet]})"
    lon2house( swe_calc_ut(julian_day, planet)[0] )
  end
  def julday(date)
    y, m, d = date.split(/[-\/]/)
    y, m = y.to_i, m.to_i
    if d[/T/]
      # yyyy-mm-ddTHH:MM format assumed
      h = d[/\d\d(?=:)/].to_i + d[/(?<=:)\d\d/].to_f/60
      d = d.to_i
    else  # No time formatting included, could be integer day or float (e.g. 1981-04-12.234)
      h = (d.to_f % 1) * 24
    end
    # Used to do the @utc shift manually, now timezone gem fixes the utc in the controller instead.
    # d -= 1 if h < @utc
    # h -= @utc   # Adjust for UTC offset in timezone, make the time UT.
    Swe4r::swe_julday(y, m, d.to_i, h)
  end
  def swe_houses(julian_day, lat, long, hsys='Placidus'[0].ord)
    Swe4r::swe_houses(julian_day, lat, long, hsys)
  end
  def house_sign(house, julian_day, lat, long)
    # Find the sign position of the house-cusp (house is integer 1-12)
    # Note: since @houses exists after 'load_params', there is no need to recalculate this each time... need to re-optimize
    lon2sign( swe_houses(julian_day, lat, long)[ house ] )
  end
  def rising_sign(julian_day, lat, long)
    house_sign(1, julian_day, lat, long)
  end
  def midheaven_sign(julian_day, lat, long)
    house_sign(10, julian_day, lat, long)
  end
  def eastern(date)
    ChineseZodiac.animal_sign(date.to_date)
  end
  def numerology(date)
    #e.g. 1980-09-22T23:54 -> [1980, 9, 22] -> [9, 9, 22] -> 40 -> 4
    a = date[/^[^T]+/].split(/[-\/ ]/).map &:to_i
    a.map!{|i| digit_reduce(i) }
    digit_reduce( a.sum )
  end
  def numerology_index(num)
    a = [1,2,3,4,5,6,7,8,9,11,22,33]
    a.include?(num) ? a.index(num) : [55,0,66,0,77].index(num)
  end
  def digit_reduce(num)
    until num.digits.size < 3 && num.digits.uniq.size == 1
      num = num.digits.sum
    end
    num
  end
  def planet_data(julday)
    pdata = {}
    pstrings = []
    psigns = []
    planetlist[0..9].map do |planet|
      planet_data = swe_calc_ut(julday, planet)
      lon = planet_data[0]
      pstrings << "#{planet.capitalize} in #{lon2sign(lon)} (#{(lon%30).to_i}°#{(lon%1*60).round}')"
      psigns << lon2sign(lon)
      pdata[planet] = planet_data   # Hash each planet to its planetary position data
    end
    return [pdata, pstrings, psigns]
  end
  def trim_link(uri)
    # Links with the https:// removed from the text but kept in link
    short_link = uri[/https?:(?!.*:)\S+$/]
    #"Copyright © #{short_link} - Read more at #{uri}"
    link_to("#{short_link}", uri)
  end
  def lon2house(lon)
    # Compare a planetary body's longitude to the house cusps of the user and determine in which house the planet resides
    # Use an offset to shift the planet into the next house if it's within this small offset of the next house
    offset = 1.5    # If a planet is within 1.5 degrees of the next house, consider it in that house
    lon = ( lon + offset ) % 360
    unless @houses
      # If @houses doesn't exist yet, then create it - correction : just throw an error. @houses should exist if load_params was run and user commited
      flash[:notice] = "@houses doesn't exist yet, please commit your birth details"
      return "@houses doesn't exist yet, please commit your birth details"
    end
    # Otherwise, we have @houses as a 13-element array of ecliptic longitudes for the 1st-12th-1st cusps (1st is repeated)
    # Make array of pairs of adjacent house cusps, [ [1, 2], [2, 3],..., [12, 1] ]
    house_edges = Array(@houses.each_cons(2))
    # p lon, house_edges.find{|i,j| i <= lon && j > lon } || house_edges.find{|i,j| j < i }, house_edges.index( house_edges.find{|i,j| i < lon && j > lon } || house_edges.find{|i,j| j < i } ) + 1
    # Output the 1-based index of the pair which EITHER contain the longitude in their range or if none are found then the pair that passes over the 360/0 transition (since that's the only pair possible if no pair is found by the first method)
    house_edges.index( house_edges.find{|i,j| i <= lon && j > lon } || house_edges.find{|i,j| j < i } ) + 1
  end
  # def set_signs(psigns)
  #   # Define variables for the planet signs based on planet data
  #   @sun, @moon, @mercury, @venus, @mars, @jupiter, @saturn, @uranus, @neptune,
  #   @pluto = psigns
  # end
  def linkify(html, tag_class = "")
    # Take input html with NO <a href="..."> links and add them to any bare uri's in the text.
    # If a tag_class is specified then also amend any non-<a> tags with a class="#{class}" attribute
    html.gsub!(/(?<!\>)http.*\/\/(?:www.)?([^\s<>]+)(?<!\/)\/?/,'<a href="\0">\1</a>')
    # p html, html[/<(?!a)[^>\/]+(?=>)/]
    html.gsub!(/<(?!a)[^>\/]+\K(?=>)/," class=\"#{tag_class}\"")
    # p html
    # html
  end
end

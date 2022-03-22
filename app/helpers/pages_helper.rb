module PagesHelper
  def ra2sign(ra)
    # Convert right-ascension values to zodiac signs
    %w[Aries Taurus Gemini Cancer Leo Virgo Libra Scorpio Sagittarius Capricorn Aquarius Pisces][ (ra/30).to_i ]
  end
  def ra2num(ra)
    # Convert right-ascension values to zodiac numbers Aries=0, Pisces=11.
    (ra/30).to_i
  end
  def blurb(sun,moon,mercury,venus,mars,ascnum)
    # Inputs are the right-ascension values of each of the named planetary bodies
    text = ['I am ','',' but my emotions are rather ','','. I think in a ','',' way, but express my energy in a ','',' way. In love, I seek ','','. I take on the role of ','','.']
    # out = ["Sun in "+ra2sign(sun)+", Moon in "+ra2sign(moon)+", Mercury in "+ra2sign(mercury)+", Venus in "+ra2sign(venus)+" and Mars in "+ra2sign(mars)]
    plist = [ra2num(sun),ra2num(moon),ra2num(mercury),ra2num(mars),ra2num(venus),ascnum]
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
    # Inputs are the right-ascension values of each of the named planetary bodies
    text = "You're just a@@ @@ that feels like it's a@@ @@."
    plist = [ra2num(moon),ra2num(sun),ra2num(venus),ra2num(mars)]
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
  def planetlist
    %w[sun moon mercury venus mars jupiter saturn uranus neptune pluto]
  end
  def tz_hotlist
    # Some of the priority timezones
    ["Pacific Time (US & Canada)", "Eastern Time (US & Canada)", "Paris", "London", "Pretoria", "Melbourne", "Sydney", "Tokyo", "Beijing", "Seoul"]
  end
  def ymdhm(date)
    # Split a date into an array of year, month, day, hour and minute - for creating Time
    # Abandoned for now, lol
  end
  def swe_name(planet)
    planet = planet.upcase.tr(' ','_')  # e.g. SUN, VESTA, MEAN_NODE, TRUE_NODE, etc.
    if %w[ECL_NUT SUN MOON MERCURY VENUS MARS JUPITER SATURN URANUS NEPTUNE PLUTO MEAN_NODE TRUE_NODE MEAN_APOG OSCU_APOG EARTH CHIRON PHOLUS CERES PALLAS JUNO VESTA INTP_APOG INTP_PERG NPLANETS FICT_OFFSET NFICT_ELEM PLMOON_OFFSET AST_OFFSET CUPIDO HADES ZEUS KRONOS APOLLON ADMETOS VULKANUS POSEIDON ISIS NIBIRU HARRINGTON NEPTUNE_LEVERRIER NEPTUNE_ADAMS PLUTO_LOWELL PLUTO_PICKERING].include?(planet)
      planet = eval("Swe4r::SE_"+planet)
    else
      "fail"
    end
    planet
  end
  def swe_calc_ut(julian_day, planet)
    Swe4r::swe_calc_ut(julian_day, swe_name(planet), Swe4r::SEFLG_SWIEPH|Swe4r::SEFLG_SPEED|Swe4r::SEFLG_EQUATORIAL)#|Swe4r::SEFLG_TOPOCTR - Swe4r::SEFLG_MOSEPH instead of SEFLG_SWIEPH
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
    d -= 1 if h < @utc
    h -= @utc   # Adjust for UTC offset in timezone, make the time UT.
    Swe4r::swe_julday(y, m, d.to_i, h)
  end
  def swe_houses(julian_day, lat=-33.8, long=151.2099, hsys='Placidus'[0].ord)
    Swe4r::swe_houses(julian_day, lat, long, hsys)
  end
end

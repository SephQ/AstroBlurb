module BlurbsHelper
  def blurb_me( blurb, params, rising, julday )
    # Turn a community-generated blurb generator and user-submitted birth details into a tailored blurb for that user
    # Called from the show view of a blurb if the user has committed their birth details to params
    if params[:commit]
      return "This blurb generator is broken." unless blurb.planet_replacements  # warning for bad blurbs that lack the right attributes
      text = blurb.text.gsub(/@(ascendant|asc)\b/i,'@rising')   # Grab the blurb text and make sure @rising tags are correct
      planets = text.scan(/@\w+/)
      replacements = blurb.planet_replacements.dup  # Make a duplicate of the replacements to be edited into an array
      if replacements =~ /^\[.+?\]\*\d+$/m
        # If the user has a row of the form [row text]*n then repeat that row text n times as repeated rows
        replacements.gsub!( /^\[(.+?)\]\*(\d+)$/m ){ "#{$1}\n" * $2.to_i }
        p replacements
      end
      replacements = replacements.split(/[\n\r]+/).map{|row| row.split(/[,、]\s*/) }  # Split replacements into an array of arrays (row-separated, then comma-separated within each row)
      p replacements
      if replacements.size < planets.size
        return "Error: This blurb doesn't have enough replacement rows for the #{ planets.size } planets mentioned in the text. Someone should edit it to add #{ planets.size - replacements.size } more rows of phrases."
      end
      # rising_options = replacements[ planets.index( '@rising' ) ] # Find the list of phrases for the rising sign option
      # replacements.delete_at( planets.index( '@rising' ) )      # Delete the replacements row for the rising sign, do it manually (since it's not a planet)
      # text = rising_replacement( text, rising, rising_options ) # Replace any @rising tags first, because we have the rising sign in the params
      # se_planets = se_rename( planets )
      blurb = text.gsub(/@\w+/){|name| # For each @planet in the text, find the sign and then use that to choose the phrase
        p "BlurbsHelper name #{name}"
        name = name[1..].downcase    # Remove the '@' from the start and make lowercase
        if name == "rising"
          i = sign2num( rising )
          p "BlurbsHelper: HEY!!! name=#{name}, sign=#{rising}, i=#{i}, jd = #{julday.inspect.to_s}"
        elsif name =~ /_house/
          # If the name is of form @[planet]_house then it's not a sign-based reading, it's house-based
          name = name.gsub(/_house/,'')   # Remove the _house suffix
          i = swe_calc_house( julday, name ) - 1  # Calculate 1-based house and then shift to 0-based index
        elsif name == "eastern"
          # If the name is @eastern then it's not a zodiac-based reading, it's based on the Eastern lunar year
          i = eastlist.index( eastern( @date_search ) ) # Find the 0-based index of the user's Eastern year (Rat, Ox, ..., Pig)
        elsif name =~ /^(lifepath|life_path)/
          # If the name is @lifepath or @life_path it's not a sign-based reading, it's numerology based (9 options - master numbers reduced currently)
          date = @date_search   # Use the @date_search instance variable to get the date in user's local time.
          i = numerology( date )  # Calculate the life path number (includes master numbers 11, 22, 33)
          # i = i.digits.sum # Apply one last digit-sum to ensure master numbers are reduced. 9 options necessary to prevent unexpected behaviour
          i = ([*1..9] + [11, 22, 33, 44]).index(i) + 1 # If keeping master numbers, then 11->10, 22->11, 33->12 etc.
          i = i - 1   # Move to a 0-based index for the array
        else
          sign = swe_calc_sign( julday, name )
          i = sign2num( sign )
          p "BlurbsHelper: HEY!!! name=#{name}, sign=#{sign}, i=#{i}, jd = #{julday.inspect.to_s}"
        end
        replacements.shift[ i ]       # Take the next row from the replacements list, take the correct phrase. Row is removed (shift).  
      }
      fix_a_to_an(blurb)  # Fix phrases like "a adventurous" to "an adventurous" and return resulting text.
    else
      # Failsafe debugger to avoid a nil params input or the like
      "Error: you didn't click 'Blurb me!' - but you'll never see this because this function isn't called unless you do."
    end
  end
  # def se_rename( planet ) # Using PagesController function instead - merged them
  #   # Rename generic planet names (e.g. 'sun', 'moon', 'lilith') to Swiss Ephemeris body names (https://www.astro.com/swisseph/swephprg.htm#_Toc471829059 under 3.2.  Bodies (int ipl))
  #   # sun, moon, mercury, venus, mars, jupiter, saturn, uranus, neptune, pluto, mean_node, true_node, mean_apog, oscu_apog, earth, chiron, pholus, ceres, pallas, juno, vesta
  #   allowed_names = %w[SUN MOON MERCURY VENUS MARS JUPITER SATURN URANUS NEPTUNE PLUTO NORTHNODE NORTH_NODE MEAN_NODE TRUE_NODE NODE LILITH TRUE_LILITH MEAN_LILITH MEAN_APOG OSCU_APOG EARTH CHIRON PHOLUS CERES PALLAS JUNO VESTA RISING]
  #   planet = planet.upcase  # First remove case-sensitivity issues
  #   if !allowed_names.include?(planet)
  #     return "se_rename error: #{ planet } is not a valid name."
  #   end
  #   # Replace allowed abbreviations with their true Swiss Ephemeris names and add "SE_" prefix
  #     if %w[NORTHNODE NORTH_NODE NODE].include?(planet)
  #       planet = "MEAN_NODE"  # Assume the mean north node Unless @true_node is used explicity
  #     elsif %w[LILITH MEAN_LILITH].include?(planet)
  #       planet = "MEAN_APOG"  # Assume the mean Lilith (Black Moon Lilith) Unless @true_lilith is used explicity
  #     elsif %w[TRUE_LILITH].include?(planet)
  #       planet = "OSCU_APOG"
  #     end
  #     "Swe4r::SE_" + planet          # Output the Swiss Ephemeris body name e.g. "SE_SUN"
  # end
  def fix_a_to_an(text)
    # Look for places in text where a word starting with a vowel has been preceded by the word "a" incorrectly
    # Replace these "a"s with "an"s instead. (Ignore silent h words, but maintain "a historic" style https://jakubmarian.com/list-of-words-with-a-silent-h-in-english/ )
    text.gsub(/\ba\K (?=[aeiou]|hour|honest|honour|heir|11\b|8|18\b)/i,'n ')
  end
  def example_title
    "Personality Blurb by zodiac--signs.tumblr.com"
  end
  def example_text
    "I am a @sun but my emotions are rather @moon. I think in a @mercury way, but express my energy in a @mars way. In love, I seek @venus. I take on the role of @rising."
  end
  def example_planet_replacements
    "initiator, guardian, wanderer, psychic, warrior, mastermind, peacemaker, detective, explorer, entrepreneur, visionary, dreamer

intense, enduring, sparkling, deep, vibrant, composed, whimsical, overwhelming, vivid, guarded, unpredictable, extreme
    
direct, practical, lighthearted, intuitive, dynamic, fruitful, artistical, complex, curious, purposeful, logical, vague
    
combative, abiding, erratic, protective, powerful, efficient, passive, brooding, lively, focused, analytical, creative
    
passion, commitment, stimulation, security, affection, respect, support, devotion, excitement, intensity, understanding, stability
    
the pioneer, the owner, the messenger, the nurturer, the protector, the organizer, the aesthete, the mystic, the comedian, the old soul, the outlaw, the creator"
  end
  #@sun, @moon, @mercury, @venus, @mars, @jupiter, @saturn, @uranus, @neptune, @pluto, @mean_node, @true_node, @mean_lilith, @true_lilith, @earth, @chiron, @pholus, @ceres, @pallas, @juno, @vesta
end

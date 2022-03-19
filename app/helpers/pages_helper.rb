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
    blurb = ['I am ','',' but my emotions are rather ','','. I think in a ','',' way, but express my energy in a ','',' way. In love, I seek ','','. I take on the role of ','','.']
    # out = ["Sun in "+ra2sign(sun)+", Moon in "+ra2sign(moon)+", Mercury in "+ra2sign(mercury)+", Venus in "+ra2sign(venus)+" and Mars in "+ra2sign(mars)]
    plist = [ra2num(sun),ra2num(moon),ra2num(mercury),ra2num(mars),ra2num(venus),ascnum]
    blbans = [['an initiator','a guardian','a wanderer','a psychic','a warrior','a mastermind','a peacemaker','a detective','an explorer','an entrepreneur','a visionary','a dreamer'],
    ['intense','enduring','sparkling','deep','vibrant','composed','whimsical','overwhelming','vivid','guarded','unpredictable','extreme'],
    ['direct','practical','lighthearted','intuitive','dynamic','fruitful','artistical','complex','curious','purposeful','logical','vague'],
    ['combative','abiding','erratic','protective','powerful','efficient','passive','brooding','lively','focused','analytical','creative'],
    ['passion','commitment','stimulation','security','affection','respect','support','devotion','excitement','intensity','understanding','stability'],
    ['the pioneer','the owner','the messenger','the nurturer','the protector','the organizer','the aesthete','the mystic','the comedian','the old soul','the outlaw','the creator','the {ASCENDANT UNKNOWN ERROR}']]
    (0..5).each do |i|
      planet = plist[i]
      blurb[i*2+1] = blbans[i][planet]
    end
    blurb.join.gsub(/(?<= a)(?= [aeiou])/,'n')
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
    
  end
end

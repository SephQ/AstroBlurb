class Numeric
  # https://github.com/isene/ephemeris
	def deg
	  self * Math::PI / 180 
  end
  def hms
    hrs = self.to_i
    m   = ((self - hrs)*60).abs
    min = m.to_i
    sec = ((m - min)*60).to_i.abs
    return hrs, min, sec
  end
  def to_hms
    hrs, min, sec = self.hms
    return "#{hrs.to_s.rjust(2, "0")}:#{min.to_s.rjust(2, "0")}:#{sec.to_s.rjust(2, "0")}"
  end
end
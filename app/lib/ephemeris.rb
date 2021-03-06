class Ephemeris
  require_relative 'numeric'
  # https://github.com/isene/ephemeris - just including as a lib so I can adjust it manually without forking and requiring.
  attr_reader :sun, :moon, :mercury, :venus, :mars, :jupiter, :saturn, :uranus, :neptune, :pluto
  
  def body_data
  @body = {
  "sun" => {
    "N" => 0.0,
    "i" => 0.0,
    "w" => 282.9404 + 4.70935e-5 * @d,
    "a" => 1.000000,
    "e" => 0.016709 - 1.151e-9 * @d,
    "M" => 356.0470 + 0.98555 * @d},
    #"M" => 356.0470 + 0.9856002585 * @d},
  "moon" => {
    "N" => 125.1228 - 0.0529538083 * @d,
    "i" => 5.1454,
    "w" => 318.0634 + 0.1643573223 * @d,
    "a" => 60.2666, 
    "e" => 0.054900,
    "M" => 115.3654 + 13.06478 * @d},
    #"M" => 115.3654 + 13.0649929509 * @d},
  "mercury" => {
    "N" => 48.3313 + 3.24587e-5 * @d,
    "i" => 7.0047 + 5.00e-8 * @d,
    "w" => 29.1241 + 1.01444e-5 * @d,
    "a" => 0.387098,  
    "e" => 0.205635 + 5.59e-10 * @d,
    #"M" => 168.6562 + 4.09257 * @d},
    "M" => 168.6562 + 4.0923344368 * @d},
  "venus" => {
    "N" => 76.6799 + 2.46590e-5 * @d,
    "i" => 3.3946 + 2.75e-8 * @d,
    "w" => 54.8910 + 1.38374e-5 * @d,
    "a" => 0.723330,
    "e" => 0.006773 - 1.302e-9 * @d,
    #"M" => 48.0052 + 1.602206 * @d},
    "M" => 48.0052 + 1.6021302244 * @d},
  "mars" => {
    "N" => 49.5574 + 2.11081e-5 * @d,
    "i" => 1.8497 - 1.78e-8 * @d,
    "w" => 286.5016 + 2.92961e-5 * @d,
    "a" => 1.523688,
    "e" => 0.093405 + 2.516e-9 * @d,
    "M" => 18.6021 + 0.52398 * @d},
    #"M" => 18.6021 + 0.5240207766 * @d},
  "jupiter" => {
    "N" => 100.4542 + 2.76854e-5 * @d,
    "i" => 1.3030 - 1.557e-7 * @d,
    "w" => 273.8777 + 1.64505e-5 * @d,
    "a" => 5.20256,
    "e" => 0.048498 + 4.469e-9 * @d,
    "M" => 19.8950 + 0.083052 * @d},
    #"M" => 19.8950 + 0.0830853001 * @d},
  "saturn" => {
    "N" => 113.6634 + 2.38980e-5 * @d,
    "i" => 2.4886 - 1.081e-7 * @d,
    "w" => 339.3939 + 2.97661e-5 * @d,
    "a" => 9.55475,
    "e" => 0.055546 - 9.499e-9 * @d,
    "M" => 316.9670 + 0.03339 * @d},
    #"M" => 316.9670 + 0.0334442282 * @d},
  "uranus" => {
    "N" => 74.0005 + 1.3978e-5 * @d,
    "i" => 0.7733 + 1.9e-8 * @d,
    "w" => 96.6612 + 3.0565e-5 * @d,
    "a" => 19.18171 - 1.55e-8 * @d,
    "e" => 0.047318 + 7.45e-9 * @d,
    "M" => 142.5905 + 0.01168 * @d},
    #"M" => 142.5905 + 0.011725806 * @d},
  "neptune" => {
    "N" => 131.7806 + 3.0173e-5 * @d,
    "i" => 1.7700 - 2.55e-7 * @d,
    "w" => 272.8461 - 6.027e-6 * @d,
    "a" => 30.05826 + 3.313e-8 * @d,
    "e" => 0.008606 + 2.15e-9 * @d,
    "M" => 260.2471 + 0.005953 * @d},
    #"M" => 260.2471 + 0.005995147 * @d}
    # http://yorick.sourceforge.net/html_i/kepler_i.php
    # [260.2471,0.005995147, 30.05826,3.313e-8, 0.008606,2.15e-9,
    #  131.7806,3.0173e-5, 272.8461,-6.027e-6, 1.7700,-2.55e-7],    /* neptune */
    #  [239.,0.00397, 39.5,0., 0.249,0.,
    #   110.,0., 114.,0., 17.1,0.]                                   /* pluto */ Adding pluto manually
  # "pluto" => {          # This one fails, predicts Pluto in wrong spot. Trying another
  #   "N" => 110.0 + 0.0 * @d,
  #   "i" => 17.1 + 0.0 * @d,
  #   "w" => 114.0 + 0.0 * @d,
  #   "a" => 39.5 + 0.0 * @d,
  #   "e" => 0.249 + 0.0 * @d,
  #   "M" => 239.0 + 0.00397 * @d}}
    #   //        Planet neptune =  new Planet("Neptune", 60000, 131.7806, 0.000030173, 1.7700, 0.000000255, 272.8461, 0.000006027, 30.05826, 0.00000003313,
    #   //              0.008606, 0.00000000215, 260.2471, 0.005995147);
    #   //        planets.add(neptune);
    #   //
    #   //       Planet pluto =  new Planet("Pluto", 90465, 131.7806, 0.000030173, 1.7700, 0.000000255, 96.6612, 0.000030565, 50, 0.00000003313,
    #   //             0.018606, 0.00000000215, 60.2471, 0.005995147);
    #   //       planets.add(pluto);
    "pluto" => {
      "N" => 110.0 + 0.0 * @d,
      "i" => 17.1 + 0.0 * @d,
      "w" => 114.0 + 0.0 * @d,
      "a" => 39.5 + 0.0 * @d,
      "e" => 0.249 + 0.0 * @d,
      "M" => 239.0 + 0.00397 * @d}}
  end

  def hms_dms(ra, dec) # Show HMS & DMS
    # SephQ: I hate this hms format, so just hijacking and making it show ra same way as dec.
    # h, m, s = (ra/15).hms
    # ra_hms  = "#{h.to_s.rjust(2)}h #{m.to_s.rjust(2)}m #{s.to_s.rjust(2)}s"
    h, m, s = ra.hms
    ra_hms  = "#{h.to_s.rjust(2)}?? #{m.to_s.rjust(2)}'"
    d, m, s = dec.hms
    dec_dms = "#{d.to_s.rjust(3)}?? #{m.to_s.rjust(2)}?? #{s.to_s.rjust(2)}??"
    return ra_hms, dec_dms
    # return ra.to_s+'     ', dec_dms
  end

  def alt_az(ra, dec, time)
    pi      = Math::PI
    ra_h = ra/15
    #ha   = (@sidtime - ra_h)*15
    ha   = (time - ra_h)*15
    x    = Math.cos(ha.deg) * Math.cos(dec.deg)
    y    = Math.sin(ha.deg) * Math.cos(dec.deg)
    z    = Math.sin(dec.deg)
    xhor = x * Math.sin(@lat.deg) - z * Math.cos(@lat.deg)
    yhor = y
    zhor = x * Math.cos(@lat.deg) + z * Math.sin(@lat.deg)
    az   = Math.atan2(yhor, xhor)*180/pi + 180
    alt  = Math.asin(zhor)*180/pi
    return alt, az
  end

  def body_alt_az(body, time)
    self.alt_az(self.body_calc(body)[0], self.body_calc(body)[1], time)
  end

  def rts(ra, dec)
    pi      = Math::PI
    transit = (ra - @ls - @lon)/15 + 12 + @tz
    transit = (transit + 24) % 24
    cos_lha = (-Math.sin(@lat.deg) * Math.sin(dec.deg)) / (Math.cos(@lat.deg) * Math.cos(dec.deg))
    if cos_lha < -1
      rise  = "always"
      set   = "never"
    elsif cos_lha > 1
      rise  = "never"
      set   = "always"
    else
      lha   = Math.acos(cos_lha) * 180/pi
      lha_h = lha/15
      rise  = ((transit - lha_h + 24) % 24).to_hms
      set   = ((transit + lha_h + 24) % 24).to_hms
    end
    trans = transit.to_hms
    return rise, trans, set
  end

  def print

    def distf(d)
      int = d.to_i.to_s.rjust(2)
      f   = d % 1
      frc = "%.4f" % f
      return int + frc[1..5]
    end

    out   = "Planet  ??? RA          ??? Dec          ??? Dist. ??? Rise  ??? Trans ??? Set   \n"
    out  += "???????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????? \n"

    #["sun", "moon", "mercury", "venus", "mars", "jupiter", "saturn", "uranus", "neptune"].each do |p|
    # ["mercury", "venus", "mars", "jupiter", "saturn", "uranus", "neptune"].each do |p|
    ["sun", "moon", "mercury", "venus", "mars", "jupiter", "saturn", "uranus", "neptune", "pluto"].each do |p|
      o     = self.body_calc(p)
      n_o   = (p[0].upcase + p[1..]).ljust(7)
      ra_o  = o[3].ljust(11)
      dec_o = o[4].ljust(12)
      d_o   = distf(o[2])[0..-3]
      ris_o = o[5][0..-4].rjust(5)
      tra_o = o[6][0..-4].rjust(5)
      set_o = o[7][0..-4].rjust(5)

      out  += "#{n_o } ??? #{ra_o    } ??? #{dec_o    } ??? #{d_o } ??? #{ris_o} ??? #{tra_o} ??? #{set_o} \n"
    end
    return out
  end

  def initialize (date, lat, lon, tz)
    pi      = Math::PI

    def get_vars(body) # GET VARIABLES FOR THE BODY
      b = @body[body]
      return b["N"], b["i"], b["w"], b["a"], b["e"], b["M"]
    end

    def body_calc(body) # CALCULATE FOR THE BODY
      pi      = Math::PI
      n_b, i_b, w_b, a_b, e_b, m_b = self.get_vars(body)
      w_b     = (w_b + 360) % 360
      m_b     = m_b % 360
      e1      = m_b + (180/pi) * e_b * Math.sin(m_b.deg) * (1 + e_b*Math.cos(m_b.deg))
      e0      = 0
      while (e1 - e0).abs > 0.0005
        e0    = e1
        e1    = e0 - (e0 - (180/pi) * e_b * Math.sin(e0.deg) - m_b) / (1 - e_b * Math.cos(e0.deg))
      end
      e       = e1
      x       = a_b * (Math.cos(e.deg) - e_b)
      y       = a_b * Math.sqrt(1 - e_b*e_b) * Math.sin(e.deg)
      r       = Math.sqrt(x*x + y*y)
      v       = (Math.atan2(y, x)*180/pi + 360) % 360
      xeclip  = r * (Math.cos(n_b.deg) * Math.cos((v+w_b).deg) - Math.sin(n_b.deg) * Math.sin((v+w_b).deg) * Math.cos(i_b.deg))
      yeclip  = r * (Math.sin(n_b.deg) * Math.cos((v+w_b).deg) + Math.cos(n_b.deg) * Math.sin((v+w_b).deg) * Math.cos(i_b.deg))
      zeclip  = r * Math.sin((v+w_b).deg) * Math.sin(i_b.deg)
      lon     =  (Math.atan2(yeclip, xeclip)*180/pi + 360) % 360
      lat     =  Math.atan2(zeclip, Math.sqrt(xeclip*xeclip + yeclip*yeclip))*180/pi
      r_b     =  Math.sqrt(xeclip*xeclip + yeclip*yeclip + zeclip*zeclip)
      m_J     = @body["jupiter"]["M"] 
      m_S     = @body["saturn"]["M"] 
      m_U     = @body["uranus"]["M"] 
      plon    = 0
      plat    = 0
      pdist   = 0
      case body
      when "moon"
        lb     = (n_b + w_b + m_b) % 360
        db     = (lb - @ls + 360) % 360
        fb     = (lb - n_b + 360) % 360
        plon  += -1.274 * Math.sin((m_b - 2*db).deg)
        plon  +=  0.658 * Math.sin((2*db).deg)
        plon  += -0.186 * Math.sin(@ms.deg)
        plon  += -0.059 * Math.sin((2*m_b - 2*db).deg)
        plon  += -0.057 * Math.sin((m_b - 2*db + @ms).deg)
        plon  +=  0.053 * Math.sin((m_b + 2*db).deg)
        plon  +=  0.046 * Math.sin((2*db - @ms).deg)
        plon  +=  0.041 * Math.sin((m_b - @ms).deg)
        plon  += -0.035 * Math.sin(db.deg)
        plon  += -0.031 * Math.sin((m_b + @ms).deg)
        plon  += -0.015 * Math.sin((2*fb - 2*db).deg)
        plon  +=  0.011 * Math.sin((m_b - 4*db).deg)
        plat  += -0.173 * Math.sin((fb - 2*db).deg)
        plat  += -0.055 * Math.sin((m_b - fb - 2*db).deg)
        plat  += -0.046 * Math.sin((m_b + fb - 2*db).deg)
        plat  +=  0.033 * Math.sin((fb + 2*db).deg)
        plat  +=  0.017 * Math.sin((2*m_b + fb).deg)
        pdist += -0.58  * Math.cos((m_b - 2*db).deg)
        pdist += -0.46  * Math.cos(2*db.deg)
      when "jupiter"
        plon  += -0.332 * Math.sin((2*m_J - 5*m_S - 67.6).deg)
        plon  += -0.056 * Math.sin((2*m_J - 2*m_S + 21).deg)
        plon  +=  0.042 * Math.sin((3*m_J - 5*m_S + 21).deg)
        plon  += -0.036 * Math.sin((m_J - 2*m_S).deg)
        plon  +=  0.022 * Math.cos((m_J - m_S).deg)
        plon  +=  0.023 * Math.sin((2*m_J - 3*m_S + 52).deg)
        plon  += -0.016 * Math.sin((m_J - 5*m_S - 69).deg)
      when "saturn"
        plon  +=  0.812 * Math.sin((2*m_J - 5*m_S - 67.6).deg)
        plon  += -0.229 * Math.cos((2*m_J - 4*m_S - 2).deg)
        plon  +=  0.119 * Math.sin((m_J - 2*m_S - 3).deg)
        plon  +=  0.046 * Math.sin((2*m_J - 6*m_S - 69).deg)
        plon  +=  0.014 * Math.sin((m_J - 3*m_S + 32).deg)
        plat  += -0.020 * Math.cos((2*m_J - 4*m_S - 2).deg)
        plat  +=  0.018 * Math.sin((2*m_J - 6*m_S - 49).deg)
      when "uranus"
        plon  +=  0.040 * Math.sin((m_S - 2*m_U + 6).deg)
        plon  +=  0.035 * Math.sin((m_S - 3*m_U + 33).deg)
        plon  += -0.015 * Math.sin((m_J - m_U + 20).deg)
      when "pluto"
        # guessing from http://yorick.sourceforge.net/html_i/kepler_i.php and http://www.stjarnhimlen.se/comp/ppcomp.html#5
        #Cannot get pluto to stop being in Gemini during the 90's using the below, no matter what I change...
        # Abandoning Ephemeris as a whole now, since Pluto and other bodies are needing and this is too limited.
        s = (50.03+0.033459652*@d).deg;
        p = (238.95+0.003968789*@d).deg;
        plon += (238.9508 + 0.00400703*@d+
              -19.799*Math.sin(p)   +19.848*Math.cos(p)+
              +0.897*Math.sin(2.*p) -4.956*Math.cos(2.*p)+
              +0.610*Math.sin(3.*p) +1.211*Math.cos(3.*p)+
              -0.341*Math.sin(4.*p) -0.190*Math.cos(4.*p)+
              +0.128*Math.sin(5.*p) -0.034*Math.cos(5.*p)+
              -0.038*Math.sin(6.*p) +0.031*Math.cos(6.*p)+
              +0.020*Math.sin(s-p)  -0.010*Math.cos(s-p)).deg;
        plat += (-3.9082+
              -5.453*Math.sin(p)   -14.975*Math.cos(p)+
              +3.527*Math.sin(2.*p) +1.673*Math.cos(2.*p)+
              -1.051*Math.sin(3.*p) +0.328*Math.cos(3.*p)+
              +0.179*Math.sin(4.*p) -0.292*Math.cos(4.*p)+
              +0.019*Math.sin(5.*p) +0.100*Math.cos(5.*p)+
              -0.031*Math.sin(6.*p) -0.026*Math.cos(6.*p)+
              +0.011*Math.cos(s-p)).deg;
        pdist += (40.72+
            +6.68*Math.sin(p) +6.90*Math.cos(p)+
            -1.18*Math.sin(2.*p) -0.03*Math.cos(2.*p)+
            +0.15*Math.sin(3.*p) -0.14*Math.cos(3.*p));
        # xyz(1,9,..) = r*Math.cos(lon)*Math.cos(lat);
        # xyz(2,9,..) = r*Math.sin(lon)*Math.cos(lat);
      end
      lon   += plon
      lat   += plat
      r_b   += pdist
      if body == "moon"
        xeclip  = Math.cos(lon.deg) * Math.cos(lat.deg)
        yeclip  = Math.sin(lon.deg) * Math.cos(lat.deg)
        zeclip  = Math.sin(lat.deg)
      else
        xeclip += @xs
        yeclip += @ys
      end
      xequat  = xeclip
      yequat  = yeclip * Math.cos(@ecl.deg) - zeclip * Math.sin(@ecl.deg)
      zequat  = yeclip * Math.sin(@ecl.deg) + zeclip * Math.cos(@ecl.deg)
      ra      = (Math.atan2(yequat, xequat)*180/pi + 360) % 360
      dec     = Math.atan2(zequat, Math.sqrt(xequat*xequat + yequat*yequat))*180/pi
      body   == "moon" ? par = Math.asin(1/r_b)*180/pi : par = (8.794/3600)/r_b
      gclat   = @lat - 0.1924 * Math.sin(2*@lat.deg)
      rho     = 0.99833 + 0.00167 * Math.cos(2*@lat.deg)
      lst     = @sidtime * 15
      ha      = (lst - ra + 360) % 360
      g       = Math.atan(Math.tan(gclat.deg) / Math.cos(ha.deg))*180/pi
      topRA   = ra  - par * rho * Math.cos(gclat.deg) * Math.sin(ha.deg) / Math.cos(dec.deg)
      topDecl = dec - par * rho * Math.sin(gclat.deg) * Math.sin((g - dec).deg) / Math.sin(g.deg)
      ra      = topRA.round(4)
      dec     = topDecl.round(4)
      r       = Math.sqrt(xequat*xequat + yequat*yequat + zequat*zequat).round(4)
      ri, tr, se = self.rts(ra, dec)
      object  = [ra, dec, r, self.hms_dms(ra, dec), ri, tr, se].flatten
      return object
    end
      
    # START OF INITIALIZE
    @lat   = lat
    @lon   = lon
    @tz    = tz
    y      = date[0..3].to_i
    m      = date[5..6].to_i
    d      = date[8..]      # updated from [8..9].to_i, to allow for float days (will include actual time eventually)
    if d[/T/]
      # yyyy-mm-ddTHH:MM format assumed
      h_adj = d[/\d\d(?=:)/].to_i + d[/(?<=:)\d\d/].to_f/60
      d = d.to_i + h_adj/24
    else  # No time formatting included, could be integer or float (e.g. 1981-04-12.234)
      d = d.to_f
    end
    # Was simple formula below, but now updating to cover whole Gregorian calendar from: https://www.stjarnhimlen.se/comp/ppcomp.html (note these are all integer division)
    # @d     = 367*y - 7*(y + (m+9)/12) / 4 + 275*m/9 + d - 730530
    @d     = 367*y - 7*(y + (m+9)/12) / 4 - 3*((y + (m-9)/7)/100 + 1)/4 + 275*m/9 + d - 730515
    @ecl   = 23.4393 - 3.563E-7*@d

    self.body_data

    # SUN
    n_s, i_s, w_s, a_s, e_s, m_s = self.get_vars("sun")
    w_s      = (w_s + 360) % 360
    @ms      = m_s % 360
    es       = @ms + (180/pi) * e_s * Math.sin(@ms.deg) * (1 + e_s*Math.cos(@ms.deg))
    x        = Math.cos(es.deg) - e_s
    y        = Math.sin(es.deg) * Math.sqrt(1 - e_s*e_s)
    v        = Math.atan2(y,x)*180/pi
    r        = Math.sqrt(x*x + y*y)
    tlon     = (v + w_s)%360
    @xs      = r * Math.cos(tlon.deg)
    @ys      = r * Math.sin(tlon.deg)
    xe       = @xs
    ye       = @ys * Math.cos(@ecl.deg)
    ze       = @ys * Math.sin(@ecl.deg)
    r        = Math.sqrt(xe*xe + ye*ye + ze*ze)
    ra       = Math.atan2(ye,xe)*180/pi
    ra_s     = ((ra + 360)%360).round(4)
    dec_s    = (Math.atan2(ze,Math.sqrt(xe*xe + ye*ye))*180/pi).round(4)

    @ls      = (w_s + @ms)%360
    gmst0   = (@ls + 180)/15%24
    @sidtime = gmst0 + @lon/15 
    
    @alt_s, @az_s = self.alt_az(ra_s, dec_s, @sidtime)

    @sun     = [ra_s, dec_s, 1.0, self.hms_dms(ra_s, dec_s)].flatten 
    @moon    = self.body_calc("moon")
    @mercury = self.body_calc("mercury")
    @venus   = self.body_calc("venus")
    @mars    = self.body_calc("mars")
    @jupiter = self.body_calc("jupiter")
    @saturn  = self.body_calc("saturn")
    @uranus  = self.body_calc("uranus")
    @neptune = self.body_calc("neptune")
    @pluto   = self.body_calc("pluto")      # Added manually, #plutoisstillaplanet.

  end
end
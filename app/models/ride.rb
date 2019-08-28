class Ride < ApplicationRecord
  belongs_to :beach
  has_many :userrides, dependent: :destroy
  has_many :users, through: :userrides

  has_many :messages, dependent: :destroy

  validates :date, presence: true
  validates :time_slot, presence: true

  geocoded_by :beach

  def score(info, experience)
    @scoring = wave_score(info, experience) * wind_score(info)
  end

  def wave_score(info, experience)
    sh = surf_height_score(info['surf_height'], experience)[0]
    sp = swell_period_score(info['swell_period'])[0]
    sd = swell_direction_score(info['swell_direction'])

    return wave_scoring = (sh * 7 + sp * 2 + sd)/10.0
  end

  def wind_score(info)
    ws = wind_speed_score(info['wind_speed'])[0]
    wg = wind_gust_score(info['wind_gust'] - info['wind_speed'])[0]
    wd = wind_direction_score(info['wind_direction'])[0]
    return wind_scoring = (ws * 30 + wg * 10 + wd * 10)/50/5.0
  end

  def surf_height_score(value, experience)
    scoring = 0.0
    if experience == 'Rookie'
      if value > 5 then scoring = [0.5,"huge (⚠️ very dangerous for #{experience} surfers)"]
      elsif value > 3 then scoring = [1,"upper head high (⚠️ dangerous for #{experience} surfers)"]
      elsif value > 2 then scoring = [2,"head high (💪 hard for #{experience} surfers)"]
      elsif value > 1.5 then scoring = [3,"chest high (💪 challenging for #{experience} surfers)"]
      elsif value > 1 then scoring = [4,"waist high (👌 perfect for #{experience} surfers)"]
      elsif value > 0.5 then scoring = [4.5,"knee high (🤷 why not for #{experience} surfers)"]
      else scoring = [4,"ankle high (🤷 why not for #{experience} surfers)"]
      end
    elsif experience == 'Beginner'
      if value > 5 then scoring = [1,"huge (⚠️ very dangerous for #{experience} surfers)"]
      elsif value > 3 then scoring = [2,"upper head high (⚠️ potentially dangerous for #{experience} surfers)"]
      elsif value > 2 then scoring = [3,"head high (💪 challenging for #{experience} surfers)"]
      elsif value > 1.5 then scoring = [4,"chest high (👌 perfect for #{experience} surfers)"]
      elsif value > 1 then scoring = [5,"waist high (👌 nice for #{experience} surfers)"]
      elsif value > 0.5 then scoring = [4,"knee high (🤷 why not for #{experience} surfers)"]
      else scoring = [2,"ankle high (🙄 boring for #{experience} surfers)"]
      end
    elsif experience == 'Advanced'
      if value > 5 then scoring = [2,"huge (⚠️ potentially dangerous for #{experience} surfers)"]
      elsif value > 3 then scoring = [3,"upper head high (💪 challenging for #{experience} surfers)"]
      elsif value > 2 then scoring = [4,"head high (👌 perfect for #{experience} surfers)"]
      elsif value > 1.5 then scoring = [5,"chest high (👌 nice for #{experience} surfers)"]
      elsif value > 1 then scoring = [4,"waist high (🤷 why not for #{experience} surfers)"]
      elsif value > 0.5 then scoring = [3,"knee high (🙄 boring for #{experience} surfers)"]
      else scoring = [1,"ankle high (🙄 boring for #{experience} surfers)"]
      end
    else
      if value > 5 then scoring = [5,"huge (💪 challenging for #{experience} surfers)"]
      elsif value > 3 then scoring = [4.5,"upper head high (👌 perfect for #{experience} surfers)"]
      elsif value > 2 then scoring = [4,"head high (👌 nice for #{experience} surfers)"]
      elsif value > 1.5 then scoring = [3,"chest high (🤷 why not for #{experience} surfers)"]
      elsif value > 1 then scoring = [2,"waist high (🤷 why not for #{experience} surfers)"]
      elsif value > 0.5 then scoring = [1,"knee high (🙄 boring for #{experience} surfers)"]
      else scoring = [0.5,"ankle high (🙄 boring for #{experience} surfers)"]
      end
    end
    return scoring
  end

  def swell_period_score(value)
    if value > 16 then scoring = [5,"👍 extremely powerful and spaced"]
    elsif value > 13 then scoring = [4.5, "👍 powerful and spaced"]
    elsif value > 10 then scoring = [4, "👍 well lined-up"]
    elsif value > 7 then scoring = [3, "🆗 decent surfable"]
    elsif value > 5 then scoring = [2,"👎 potentially messy"]
    else scoring = [1,"👎 weak and very messy"]
    end
  end

  def swell_direction_score(value)
    if (value - 180).abs > 150 then scoring = 0.5
    elsif (value-180).abs > 120 then scoring = 1
    elsif (value-180).abs > 90 then scoring = 2
    elsif (value-180).abs > 60 then scoring = 3
    elsif (value-180).abs > 30 then scoring = 4
    else scoring = 5
    end
  end

  def wind_speed_score(value)
    if value > 30 then scoring = [1,"👎👎👎 extremely powerful"]
    elsif value > 25 then scoring = [2,"👎👎 very strong"]
    elsif value > 20 then scoring = [3,"👎 strong"]
    elsif value > 15 then scoring = [3,"👍 medium"]
    elsif value > 10 then scoring = [4.5,"👍👍 light"]
    else scoring = [5,"👍👍👍 light breeze"]
    end
  end

  def wind_gust_score(value)
    if value > 16 then scoring = [0.5, "👎👎👎 violent gusts"]
    elsif value > 13 then scoring = [1,"👎👎 strong gusts"]
    elsif value > 10 then scoring = [2,"👎 medium to strong gusts"]
    elsif value > 7 then scoring = [3,"👍 few gusts"]
    elsif value > 4 then scoring = [4,"👍👍 light gusts"]
    else scoring = [5,"👍👍👍 no gusts"]
    end
  end

  def wind_direction_score(value)
    if (value - 180).abs > 150 then scoring = [0.5, "👎👎👎 disturbing onshore"]
    elsif (value-180).abs > 120 then scoring = [1, "👎👎 annoying lateral onshore"]
    elsif (value-180).abs > 90 then scoring = [2, "🆗 lateral"]
    elsif (value-180).abs > 60 then scoring = [3, "🆗 lateral"]
    elsif (value-180).abs > 30 then scoring = [4, "👍👍 lateral offshore"]
    else scoring = [5, "👍👍👍 nice offshore"]
    end
  end

  def cloud_score(value)
    if value > 95 then scoring = [0.5, "☁️☁️☁️ totally covered with clouds"]
    elsif value > 80 then scoring = [1,"☁️☁️ very cloudy sky"]
    elsif value > 60 then scoring = [2,"☁️ cloudy sky"]
    elsif value > 40 then scoring = [3,"⛅ cloudy sky with sunny spells"]
    elsif value > 20 then scoring = [4,"☀️ sunny sky"]
    else scoring = [5,"☀️☀️ blue sky"]
    end

  end

end

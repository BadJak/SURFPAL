class Ride < ApplicationRecord
  belongs_to :beach
  has_many :userrides, dependent: :destroy
  has_many :users, through: :userrides

  has_many :messages, dependent: :destroy

  validates :date, presence: true
  validates :time_slot, presence: true

  geocoded_by :beach

  def distance(value)
    if value == "25km" then distance = 25
    elsif value == "50km" then distance = 50
    elsif value == "75km" then distance = 75
    else distance = 100
    end
    return distance
  end

  def score(info, experience)
    @scoring = wave_score(info, experience) * wind_score(info)
  end

  def wave_score(info, experience)

    sp = swell_period_score(info['swell_period'])[0]
    sd = swell_direction_score(info['swell_direction'])
    calc_surf_height = info['swell_height']*(sp+sd)*3/5.0
    sh = surf_height_score(calc_surf_height, experience)[0]
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
      if value > 5 then scoring = [0.5,"Huge waves (very dangerous for #{experience} surfers)","⚠️"]
      elsif value > 3 then scoring = [1,"Upper head high waves (dangerous for #{experience} surfers)","⚠️"]
      elsif value > 2 then scoring = [2,"Head high waves (hard for #{experience} surfers)","💪"]
      elsif value > 1.5 then scoring = [3,"Chest high waves (challenging for #{experience} surfers)","💪"]
      elsif value > 1 then scoring = [4,"Waist high waves (perfect for #{experience} surfers)","👌"]
      elsif value > 0.5 then scoring = [4.5,"Knee high waves (why not for #{experience} surfers)","🤷"]
      else scoring = [4,"Ankle high waves (why not for #{experience} surfers)","🤷"]
      end
    elsif experience == 'Beginner'
      if value > 5 then scoring = [1,"Huge waves (very dangerous for #{experience} surfers)","⚠️"]
      elsif value > 3 then scoring = [2,"Upper head high waves (potentially dangerous for #{experience} surfers)","⚠️"]
      elsif value > 2 then scoring = [3,"Head high waves (challenging for #{experience} surfers)","💪"]
      elsif value > 1.5 then scoring = [4,"Chest high waves (perfect for #{experience} surfers)","👌"]
      elsif value > 1 then scoring = [5,"Waist high waves (nice for #{experience} surfers)","👌"]
      elsif value > 0.5 then scoring = [4,"Knee high waves (why not for #{experience} surfers)","🤷"]
      else scoring = [2,"Ankle high waves (boring for #{experience} surfers)","🙄"]
      end
    elsif experience == 'Advanced'
      if value > 5 then scoring = [2,"Huge waves (potentially dangerous for #{experience} surfers)","⚠️"]
      elsif value > 3 then scoring = [3,"Upper head high waves (challenging for #{experience} surfers)","💪"]
      elsif value > 2 then scoring = [4,"Head high waves (perfect for #{experience} surfers)","👌"]
      elsif value > 1.5 then scoring = [5,"Chest high waves (nice for #{experience} surfers)","👌"]
      elsif value > 1 then scoring = [4,"Waist high waves (why not for #{experience} surfers)","🤷"]
      elsif value > 0.5 then scoring = [3,"Knee high waves (boring for #{experience} surfers)","🙄"]
      else scoring = [1,"Ankle high waves (boring for #{experience} surfers)","🙄"]
      end
    else
      if value > 5 then scoring = [5,"Huge waves (challenging for #{experience} surfers)","💪"]
      elsif value > 3 then scoring = [4.5,"Upper head high waves (perfect for #{experience} surfers)","👌"]
      elsif value > 2 then scoring = [4,"Head high waves (nice for #{experience} surfers)","👌"]
      elsif value > 1.5 then scoring = [3,"Chest high waves (why not for #{experience} surfers)","🤷"]
      elsif value > 1 then scoring = [2,"Waist high waves (why not for #{experience} surfers)","🤷"]
      elsif value > 0.5 then scoring = [1,"Knee high waves (boring for #{experience} surfers)","🙄"]
      else scoring = [0.5,"Ankle high waves (boring for #{experience} surfers)","🙄"]
      end
    end
    return scoring
  end

  def swell_period_score(value)
    if value > 16 then scoring = [5,"extremely powerful and spaced","👍"]
    elsif value > 13 then scoring = [4.5, "powerful and spaced","👍"]
    elsif value > 10 then scoring = [4, "well lined-up","👍"]
    elsif value > 7 then scoring = [3, "decent surfable","🆗"]
    elsif value > 5 then scoring = [2,"potentially messy","👎"]
    else scoring = [1,"weak and very messy","👎"]
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
    if value > 30 then scoring = [1,"Extremely powerful","👎👎"]
    elsif value > 25 then scoring = [2,"Very strong","👎"]
    elsif value > 20 then scoring = [3,"Strong",""]
    elsif value > 15 then scoring = [3,"Medium",""]
    elsif value > 10 then scoring = [4.5,"Light","👍"]
    else scoring = [5,"Light breeze","👍👍"]
    end
  end

  def wind_gust_score(value)
    if value > 16 then scoring = [0.5, "violent gusts","👎👎"]
    elsif value > 13 then scoring = [1,"strong gusts","👎"]
    elsif value > 10 then scoring = [2,"medium to strong gusts",""]
    elsif value > 7 then scoring = [3,"few gusts",""]
    elsif value > 4 then scoring = [4,"light gusts","👍"]
    else scoring = [5,"no gusts","👍👍"]
    end
  end

  def wind_direction_score(value)
    if (value - 180).abs > 150 then scoring = [0.5, "disturbing onshore","👎👎"]
    elsif (value-180).abs > 120 then scoring = [1, "annoying lateral onshore","👎"]
    elsif (value-180).abs > 90 then scoring = [2, "lateral","🆗"]
    elsif (value-180).abs > 60 then scoring = [3, "lateral","🆗"]
    elsif (value-180).abs > 30 then scoring = [4, "lateral offshore","👍"]
    else scoring = [5, "nice offshore","👍👍"]
    end
  end

  def cloud_score(value)
    if value > 95 then scoring = [0.5, "totally covered with clouds","☁️☁️"]
    elsif value > 80 then scoring = [1,"very cloudy sky","☁️"]
    elsif value > 60 then scoring = [2,"cloudy sky","☁️"]
    elsif value > 40 then scoring = [3,"cloudy sky with sunny spells","⛅"]
    elsif value > 20 then scoring = [4,"sunny sky","☀️"]
    else scoring = [5,"blue sky","☀️"]
    end

  end

end

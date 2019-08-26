class Ride < ApplicationRecord
  belongs_to :beach
  has_many :userrides, dependent: :destroy
  has_many :users, through: :userrides

  has_many :messages, dependent: :destroy

  validates :date, presence: true
  validates :time_slot, presence: true

  geocoded_by :beach

  def score(info, experience)
    @scoring = wave(info, experience) * wind(info)
  end

  def wave(info, experience)
    sh = surf_height(info['surf_height'], experience)
    sp = swell_period(info['swell_period'])
    return wave_scoring = (sh * 8 + sp * 2)/10.0
  end

  def wind(info)
    ws = wind_speed(info['wind_speed'])
    wg = wind_gust(info['wind_gust'])
    wd = wind_direction(info['wind_direction'])
    return wind_scoring = (ws * 30 + wg * 10 + wd * 10)/50/5.0
  end

  def surf_height(value, experience)
    scoring = 0.0
    if experience == 'Rookie'
      if value > 5 then scoring = 0.5
      elsif value > 3 then scoring = 1
      elsif value > 2 then scoring = 2
      elsif value > 1.5 then scoring = 3
      elsif value > 1 then scoring = 4
      elsif value > 0.5 then scoring = 4.5
      else scoring = 4
      end
    elsif experience == 'Beginner'
      if value > 5 then scoring = 1
      elsif value > 3 then scoring = 2
      elsif value > 2 then scoring = 3
      elsif value > 1.5 then scoring = 4
      elsif value > 1 then scoring = 5
      elsif value > 0.5 then scoring = 4
      else scoring = 2
      end
    elsif experience == 'Advanced'
      if value > 5 then scoring = 2
      elsif value > 3 then scoring = 3
      elsif value > 2 then scoring = 4
      elsif value > 1.5 then scoring = 5
      elsif value > 1 then scoring = 4
      elsif value > 0.5 then scoring = 3
      else scoring = 1
      end
    else
      if value > 5 then scoring = 5
      elsif value > 3 then scoring = 4.5
      elsif value > 2 then scoring = 4
      elsif value > 1.5 then scoring = 3
      elsif value > 1 then scoring = 2
      elsif value > 0.5 then scoring = 1
      else scoring = 0.5
      end
    end
    return scoring
  end

  def swell_period(value)
    if value > 16 then scoring = 5
    elsif value > 13 then scoring = 4.5
    elsif value > 10 then scoring = 4
    elsif value > 7 then scoring = 3
    elsif value > 5 then scoring = 2
    else scoring = 1
    end
  end

  def swell_direction(value)
  end

  def wind_speed(value)
    if value > 30 then scoring = 1
    elsif value > 25 then scoring = 2
    elsif value > 20 then scoring = 3
    elsif value > 15 then scoring = 4
    elsif value > 10 then scoring = 4.5
    else scoring = 5
    end
  end

  def wind_gust(value)
    if value > 16 then scoring = 0.5
    elsif value > 13 then scoring = 1
    elsif value > 10 then scoring = 2
    elsif value > 7 then scoring = 3
    elsif value > 4 then scoring = 4
    else scoring = 5
    end
  end

  def wind_direction(value)
    if (value - 180).abs > 150 then scoring = 0.5
    elsif (value-180).abs > 120 then scoring = 1
    elsif (value-180).abs > 90 then scoring = 2
    elsif (value-180).abs > 60 then scoring = 3
    elsif (value-180).abs > 30 then scoring = 4
    else scoring = 5
    end
  end
end

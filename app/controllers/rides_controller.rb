require 'date'
require 'json'

class RidesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    create
    if params[:location].present? && params[:date].present? && params[:time].present? && params[:experience].present?
      @rides = policy_scope(Ride)
      unsorted_rides = @rides.near(params[:location],Ride.new.distance(params[:distance])).where(date: Date.strptime(params[:date][:date], '%Y-%m-%d'), time_slot: params[:time])
      score = "#{params[:experience].downcase}_score"
      @rides = unsorted_rides.sort_by { |k| -k[score]}
      @results = Geocoder.search(params[:location])
        if @rides.empty? || @results.blank?
          @markers = {
           lat: -7.6388718,
           lng: 33.5924503
          }
        else
          @markers = @rides.map do |ride|
            {
             lat: ride.latitude,
             lng: ride.longitude
            }
          end
        end
    else
      redirect_to root_path
    end
  end

  def show
    @ride = Ride.find(params[:id])
    authorize @ride
  end

  def format_time(time)
    if time == 'Morning'
      formatted_time = "600"
    elsif time == 'Noon'
      formatted_time = "1200"
    else
      formatted_time = "1800"
    end
    return formatted_time
  end

  private

  def create
    @rides = Ride.near(params[:location],Ride.new.distance(params[:distance]))
    result = @rides.find do |ride|
      if params[:date][:date] == ""
        params[:date][:date] = Date.today.strftime('%Y-%m-%d')
      else
      Date.strptime(params[:date][:date], '%Y-%m-%d') == ride.date &&
      params[:time] == ride.time_slot
      end
    end
    if result.nil?
      @beaches = Beach.near(params[:location],Ride.new.distance(params[:distance]))
      @beaches.each do |beach|
        info = fetch_data(beach[:longitude], beach[:latitude], 6)
        calcSH = info['swell_height'] * (Ride.new.swell_period_score(info['swell_period'])[0] + Ride.new.swell_direction_score(info['swell_direction'])) * 3 / 5.0
        @ride = Ride.create(
          date: Date.strptime(params[:date][:date], '%Y-%m-%d'),
          time_slot: params[:time],
          beach_id: beach.id,
          wave_height: calcSH,
          swell_height: info['swell_height'],
          swell_period: info['swell_period'],
          swell_direction: info['swell_direction'],
          wind_speed: info['wind_speed'],
          wind_direction: info['wind_direction'],
          wind_gust: info['wind_gust'],
          longitude: beach.longitude,
          latitude: beach.latitude,
          air_temp: info['air_temp'],
          water_temp: info['water_temp'],
          wind_compass: info['wind_compass'],
          swell_compass: info['swell_compass'],
          weather_description: info['weather_description'],
          cloud_cover: info['cloud_cover'],
          rookie_score: Ride.new.score(info, "Rookie"),
          beginner_score: Ride.new.score(info, "Beginner"),
          advanced_score: Ride.new.score(info, "Advanced"),
          pro_score: Ride.new.score(info, "Pro")
          )
      end
    end
  end

  def fetch_data(lng,lat,tp)
    conn = Faraday.new(:url => "http://api.worldweatheronline.com/premium/v1/marine.ashx")
    response = conn.get "?key=#{ENV["WWO_API_KEY"]}&format=json&q=#{lng},#{lat}&tp=#{tp}"
    api_data = JSON.parse(response.body)
    data = api_data['data']['weather']
    selected_date = data.select do |item|
      item['date'] == params[:date]['date']
    end
    selected_time = selected_date.first['hourly'].select do |item|
      item['time'] == format_time(params[:time])
    end
    info = {
      'air_temp' => selected_time.first['tempC'].to_i,
      'water_temp' => selected_time.first['waterTemp_C'].to_i,
      'wind_compass' => selected_time.first['winddir16Point'],
      'swell_compass' => selected_time.first['swellDir16Point'],
      'weather_description' => selected_time.first['weatherDesc'].first['value'],
      'cloud_cover' => selected_time.first['cloudcover'].to_i,
      'surf_height' => selected_time.first['sigHeight_m'].to_f,
      'swell_height' => selected_time.first['swellHeight_m'].to_f,
      'swell_period' => selected_time.first['swellPeriod_secs'].to_f,
      'swell_direction' => selected_time.first['swellDir'].to_i,
      'wind_speed' => selected_time.first['windspeedKmph'].to_i,
      'wind_direction' => selected_time.first['winddirDegree'].to_i,
      'wind_gust' => selected_time.first['WindGustKmph'].to_i
    }
    return info
  end
end

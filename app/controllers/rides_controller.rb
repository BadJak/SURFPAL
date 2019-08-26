require 'date'
require 'json'
API_KEY = "9591ab6696f44435ab0162000192408"

class RidesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    create
    if params[:location].present? && params[:date].present? && params[:time].present? && params[:experience].present?
      @rides = policy_scope(Ride)
      unsorted_rides = @rides.near(params[:location], 100).where(date: Date.strptime(params[:date][:date], '%Y-%m-%d'), time_slot: params[:time])
      score = "#{params[:experience].downcase}_score"
      @rides = unsorted_rides.sort_by { |k| -k[score]}
        if @rides.empty?
          results = Geocoder.search(params[:location])
          @markers = {
             lat: results.first.coordinates[0],
             lng: results.first.coordinates[1]
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

  # def format_date(date)
  #   formatted_date = Date.strptime(date[:date], '%Y-%m-%d').to_time.to_i
  #   return formatted_date
  # end

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
    @rides = Ride.near(params[:location], 100)
    result = @rides.find do |ride|
      Date.strptime(params[:date][:date], '%Y-%m-%d') == ride.date &&
      params[:time] == ride.time_slot
    end
    if result.nil?
      @beaches = Beach.near(params[:location], 100)
      @beaches.each do |beach|
        info = fetch_data(beach[:longitude], beach[:latitude], 6)
        @ride = Ride.create(
          date: Date.strptime(params[:date][:date], '%Y-%m-%d'),
          time_slot: params[:time],
          beach_id: beach.id,
          wave_height: info['surf_height'],
          swell_height: info['swell_height'],
          swell_period: info['swell_period'],
          swell_direction: info['swell_direction'],
          wind_speed: info['wind_speed'],
          wind_direction: info['wind_direction'],
          wind_gust: info['wind_gust'],
          longitude: beach.longitude,
          latitude: beach.latitude,
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
    response = conn.get "?key=#{API_KEY}&format=json&q=#{lng},#{lat}&tp=#{tp}"
    api_data = JSON.parse(response.body)
    data = api_data['data']['weather']
    selected_date = data.select do |item|
      item['date'] == params[:date]['date']
    end
    selected_time = selected_date.first['hourly'].select do |item|
      item['time'] == format_time(params[:time])
    end
    info = {
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

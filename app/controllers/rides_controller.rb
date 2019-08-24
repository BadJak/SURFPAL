require 'date'
require 'json'

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

  def format_date(date, time)
    formatted_date = Date.strptime(date[:date], '%Y-%m-%d').to_time.to_i
    if time == 'morning'
      formatted_date += 21600
    elsif time == 'noon'
      formatted_date += 43200
    else
      formatted_date += 64800
    end
    return formatted_date
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
        wave_info = fetch_data('wave', beach[:surfline_id])
        wind_info = fetch_data('wind', beach[:surfline_id])
        @ride = Ride.create(
          date: Date.strptime(params[:date][:date], '%Y-%m-%d'),
          time_slot: params[:time],
          beach_id: beach.id,
          wave_height: wave_info['surf_height'],
          swell_height: wave_info['swell_height'],
          swell_period: wave_info['swell_period'],
          swell_direction: wave_info['swell_direction'],
          wind_speed: wind_info['wind_speed'],
          wind_direction: wind_info['wind_direction'],
          wind_gust: wind_info['wind_gust'],
          longitude: beach.longitude,
          latitude: beach.latitude,
          rookie_score: Ride.new.score(wave_info, wind_info, "Rookie"),
          beginner_score: Ride.new.score(wave_info, wind_info,"Beginner"),
          advanced_score: Ride.new.score(wave_info, wind_info,"Advanced"),
          pro_score: Ride.new.score(wave_info, wind_info,"Pro")
          )
      end
    end
  end

  def fetch_data(type, spot_id)
    conn = Faraday.new(:url => 'http://services.surfline.com')
    response = conn.get "/kbyg/spots/forecasts/#{type}?spotId=#{spot_id}&days=6&intervalHours=6"
    surfline_data = JSON.parse(response.body)
    data = surfline_data['data']["#{type}"]
    selected_item = data.select do |item|
      item['timestamp'] == format_date(params[:date], params[:time])
    end
    if type == 'wave'
      info = {
        'surf_height' => (selected_item.first['surf']['min'] + selected_item.first['surf']['max']) / 2.0,
        'swell_height' => selected_item.first['swells'].first['height'],
        'swell_period' => selected_item.first['swells'].first['period'],
        'swell_direction' => selected_item.first['swells'].first['direction']
      }
    elsif type == 'wind'
      info = {
        'wind_speed' => selected_item.first['speed'],
        'wind_direction' => selected_item.first['direction'],
        'wind_gust' => selected_item.first['gust']
      }
    end
    return info
  end
end

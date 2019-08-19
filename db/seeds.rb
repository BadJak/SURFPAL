# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# request = "http://services.surfline.com/kbyg/spots/forecasts/wave?spotId=5842041f4e65fad6a7708cf6&days=6&intervalHours=6"

Beach.destroy_all
Ride.destroy_all

beaches = [
  {
    name: "Plage de Dar Bouazza",
    city: "Dar Bouazza",
    lon: -7.817519444,
    lat: 33.53641111,
    surfline_name: "dar-bouazza",
    surfline_id: "5842041f4e65fad6a7708cf6"
  },

  {
    name: "Plage de Bouznika",
    city: "Bouznika",
    lon: -7.152102778,
    lat: 33.82546944,
    surfline_name: "bouznika-plage",
    surfline_id: "5842041f4e65fad6a7708cfb"
  },

  {
    name: "Oued Cherrat",
    city: "Bouznika",
    lon: -7.129163889,
    lat: 33.83184722,
    surfline_name: "oued-cherrat",
    surfline_id: "5842041f4e65fad6a7708cfc"
  },

  { name: "Doura",
    city: "Rabat",
    lon: -6.837330556,
    lat: 34.03740833,
    surfline_name: "doura",
    surfline_id: "5842041f4e65fad6a7708cfe"
  },

  { name: "The Money Wave",
    city: "Safi",
    lon: -9.259630556,
    lat: 32.23053611,
    surfline_name: "the-money-wave",
    surfline_id: "5842041f4e65fad6a7708cf5"
  },

  { name: "The Boiler",
    city: "Agadir",
    lon: -9.87905,
    lat: 30.62215833,
    surfline_name: "the-boiler",
    surfline_id: "5842041f4e65fad6a7708cf3"
  },

  { name: "Imsouane",
    city: "Imsouane",
    lon: -9.810962677001953,
    lat: 30.837098989902422,
    surfline_name: "imsouane",
    surfline_id: "58bdf7c682d034001252e3d6"
  },

  { name: "Sidi Ghouzia",
    city: "Sidi Ghouzia",
    lon: -9.258480556,
    lat: 32.31853056,
    surfline_name: "sidi-ghouzia",
    surfline_id: "5842041f4e65fad6a7708cf7"
  },

  { name: "Anchor Point",
    city: "Taghazout",
    lon: -9.743236111,
    lat: 30.55033611,
    surfline_name: "anchor-point",
    surfline_id: "5842041f4e65fad6a7708cfd"
  },

  { name: "Mysteries",
    city: "Taghazout",
    lon: -9.715966,
    lat: 30.545021,
    surfline_name: "mysteries",
    surfline_id: "5842041f4e65fad6a7708cf9"
  },

  { name: "Killers",
    city: "Taghazout",
    lon: -9.738317,
    lat: 30.553444,
    surfline_name: "killers",
    surfline_id: "5842041f4e65fad6a7708cfa"
  },
]

beaches.each do |beach|
  Beach.create(
    name: beach[:name],
    city: beach[:city],
    lon: beach[:lon],
    lat: beach[:lat],
    surfline_name: beach[:surfline_name],
    surfline_id: beach[:surfline_id]
    )
end

rides = [
  {
    date: "20/08/2019",
    time_slot: "morning",
    beach_id: Beach.first.id,
    wave_height: 1.21,
    swell_period: 7.0,
    wind_speed: 7.06,
    wind_direction: 28.66,
    wind_gust: 9.71,
    longitude: Beach.first.lon,
    latitude: Beach.first.lat
  },

  {
    date: "20/08/2019",
    time_slot: "afternoon",
    beach_id: Beach.second.id,
    wave_height: 2.4,
    swell_period: 4.0,
    wind_speed: 7.06,
    wind_direction: 28.66,
    wind_gust: 9.71,
    longitude: Beach.second.lon,
    latitude: Beach.second.lat
  },

  {
    date: "20/08/2019",
    time_slot: "morning",
    beach_id: Beach.third.id,
    wave_height: 2.21,
    swell_period: 12.0,
    wind_speed: 15.06,
    wind_direction: 65.66,
    wind_gust: 9.71,
   longitude: Beach.third.lon,
   latitude: Beach.third.lat
  },

  {
    date: "20/08/2019",
    time_slot: "noon",
    beach_id: Beach.fourth.id,
    wave_height: 1.21,
    swell_period: 7.0,
    wind_speed: 7.06,
    wind_direction: 128.66,
    wind_gust: 9.71,
    longitude: Beach.fourth.lon,
    latitude: Beach.fourth.lat
  },

  {
    date: "20/08/2019",
    time_slot: "morning",
    beach_id: Beach.fifth.id,
    wave_height: 1.04,
    swell_period: 10.0,
    wind_speed: 12.06,
    wind_direction: 28.66,
    wind_gust: 9.71,
    longitude: Beach.fifth.lon,
    latitude: Beach.fifth.lat
  },

    {
    date: "21/08/2019",
    time_slot: "morning",
    beach_id: Beach.first.id,
    wave_height: 0.21,
    swell_period: 16.0,
    wind_speed: 9.06,
    wind_direction: 28.66,
    wind_gust: 9.71,
   longitude: Beach.first.lon,
   latitude: Beach.first.lat
  },

  {
    date: "21/08/2019",
    time_slot: "morning",
    beach_id: Beach.second.id,
    wave_height: 1.21,
    swell_period: 7.0,
    wind_speed: 7.06,
    wind_direction: 28.66,
    wind_gust: 9.71,
    longitude: Beach.second.lon,
    latitude: Beach.second.lat
  },

  {
    date: "21/08/2019",
    time_slot: "morning",
    beach_id: Beach.third.id,
    wave_height: 1.21,
    swell_period: 7.0,
    wind_speed: 7.06,
    wind_direction: 28.66,
    wind_gust: 9.71,
    longitude: Beach.third.lon,
    latitude: Beach.third.lat
  },

  {
    date: "22/08/2019",
    time_slot: "morning",
    beach_id: Beach.fourth.id,
    wave_height: 1.76,
    swell_period: 7.0,
    wind_speed: 7.06,
    wind_direction: 28.66,
    wind_gust: 9.71,
    longitude: Beach.fourth.lon,
    latitude: Beach.fourth.lat
  },

  {
    date: "22/08/2019",
    time_slot: "morning",
    beach_id: Beach.fifth.id,
    wave_height: 1.21,
    swell_period: 7.0,
    wind_speed: 7.06,
    wind_direction: 28.66,
    wind_gust: 9.71,
    longitude: Beach.fifth.lon,
    latitude: Beach.fifth.lat
  },

  {
    date: "22/08/2019",
    time_slot: "morning",
    beach_id: Beach.last.id,
    wave_height: 1.21,
    swell_period: 7.0,
    wind_speed: 7.06,
    wind_direction: 28.66,
    wind_gust: 9.71,
    longitude: Beach.last.lon,
    latitude: Beach.last.lat
  }
]

rides.each do |ride|
  Ride.create(
    date: ride[:date],
    time_slot: ride[:time_slot],
    beach_id: ride[:beach_id],
    wave_height: ride[:wave_height],
    swell_period: ride[:swell_period],
    wind_speed: ride[:wind_speed],
    wind_direction: ride[:wind_direction],
    wind_gust: ride[:wind_gust],
    longitude: ride[:longitude],
    latitude: ride[:latitude]
    )
end

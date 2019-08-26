# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# request = "http://services.surfline.com/kbyg/spots/forecasts/wave?spotId=5842041f4e65fad6a7708cf6&days=6&intervalHours=6"

Ride.destroy_all
Beach.destroy_all

beaches = [
  {
    name: "Plage de Dar Bouazza",
    city: "Dar Bouazza",
    longitude: -7.817519444,
    latitude: 33.53641111,
    surfline_name: "dar-bouazza",
    surfline_id: "5842041f4e65fad6a7708cf6",
    image_url: "https://upload.wikimedia.org/wikipedia/commons/0/01/Tamaris_beach%2C_Dar_bouazza.JPG",
  },

  {
    name: "Plage de Bouznika",
    city: "Bouznika",
    longitude: -7.152102778,
    latitude: 33.82546944,
    surfline_name: "bouznika-plage",
    surfline_id: "5842041f4e65fad6a7708cfb",
    image_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRdpVUH_6n3gvk03aIu6wZpUW2gosM3lctIt5co2HxDH82tSHDn",
  },

  {
    name: "Oued Cherrat",
    city: "Bouznika",
    longitude: -7.129163889,
    latitude: 33.83184722,
    surfline_name: "oued-cherrat",
    surfline_id: "5842041f4e65fad6a7708cfc",
    image_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSdVWoiXzE2kl8_s9GfFCFzQeEjU6ci575NUAAlN9NMuo_KY-3F",
  },

  { name: "Doura",
    city: "Rabat",
    longitude: -6.837330556,
    latitude: 34.03740833,
    surfline_name: "doura",
    surfline_id: "5842041f4e65fad6a7708cfe",
    image_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQFxgGGlraWSM7KrweXZLkGvPgbRz3dToVIA3mMqybdiAOnJ48i",
  },

  { name: "The Money Wave",
    city: "Safi",
    longitude: -9.259630556,
    latitude: 32.23053611,
    surfline_name: "the-money-wave",
    surfline_id: "5842041f4e65fad6a7708cf5",
    image_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQFxgGGlraWSM7KrweXZLkGvPgbRz3dToVIA3mMqybdiAOnJ48i"
  },

  { name: "The Boiler",
    city: "Tamri",
    longitude: -9.87905,
    latitude: 30.62215833,
    surfline_name: "the-boiler",
    surfline_id: "5842041f4e65fad6a7708cf3",
    image_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQVaVhs6ofl3UuruG8gcf6zeWCF3FO_8APhRXJt4tUjiEtQvPXD",
  },

  { name: "Imsouane",
    city: "Tamri",
    longitude: -9.810962677001953,
    latitude: 30.837098989902422,
    surfline_name: "imsouane",
    surfline_id: "58bdf7c682d034001252e3d6",
    image_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR8c4rU8fJsr-Tm_c-pHdysYR-iAxsK26xnx_ABiqEO4bp1KHXE",
  },

  { name: "Sidi Ghouzia",
    city: "Safi",
    longitude: -9.258480556,
    latitude: 32.31853056,
    surfline_name: "sidi-ghouzia",
    surfline_id: "5842041f4e65fad6a7708cf7",
    image_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS45DivJTqN6qovD-Kd9nhGxAkEPw30dk0rcHJZRNrFqc_C-uiM",
  },

  { name: "Anchor Point",
    city: "Taghazout",
    longitude: -9.743236111,
    latitude: 30.55033611,
    surfline_name: "anchor-point",
    surfline_id: "5842041f4e65fad6a7708cfd",
    image_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQKDgWD239Mch4Qkcgg0pwqL-bm7KhOIpHa8UcaCQMBSykXTlQYAw",
  },

  { name: "Mysteries",
    city: "Taghazout",
    longitude: -9.715966,
    latitude: 30.545021,
    surfline_name: "mysteries",
    surfline_id: "5842041f4e65fad6a7708cf9",
    image_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTTHDCXRgd2LomseX7HJtAEffodXzKCyq1IP72wvme7xeOq6U-JIw",
  },

  { name: "Killers",
    city: "Taghazout",
    longitude: -9.738317,
    latitude: 30.553444,
    surfline_name: "killers",
    surfline_id: "5842041f4e65fad6a7708cfa",
    image_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQVV9zmqHVYj0xtShuEllkyJpb_G_6h8hRfy7A-bTEWNeNJxpI4",
  },
]

beaches.each do |beach|
  b = Beach.create(
    name: beach[:name],
    city: beach[:city],
    longitude: beach[:longitude],
    latitude: beach[:latitude],
    surfline_name: beach[:surfline_name],
    surfline_id: beach[:surfline_id]
    )
  b.remote_photo_url = beach[:image_url]
  b.save
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
    longitude: Beach.first.longitude,
    latitude: Beach.first.latitude
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
    longitude: Beach.second.longitude,
    latitude: Beach.second.latitude
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
   longitude: Beach.third.longitude,
   latitude: Beach.third.latitude
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
    longitude: Beach.fourth.longitude,
    latitude: Beach.fourth.latitude
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
    longitude: Beach.fifth.longitude,
    latitude: Beach.fifth.latitude
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
   longitude: Beach.first.longitude,
   latitude: Beach.first.latitude
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
    longitude: Beach.second.longitude,
    latitude: Beach.second.latitude
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
    longitude: Beach.third.longitude,
    latitude: Beach.third.latitude
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
    longitude: Beach.fourth.longitude,
    latitude: Beach.fourth.latitude
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
    longitude: Beach.fifth.longitude,
    latitude: Beach.fifth.latitude
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
    longitude: Beach.last.longitude,
    latitude: Beach.last.latitude
  }
]

# rides.each do |ride|
#   Ride.create(
#     date: ride[:date],
#     time_slot: ride[:time_slot],
#     beach_id: ride[:beach_id],
#     wave_height: ride[:wave_height],
#     swell_period: ride[:swell_period],
#     wind_speed: ride[:wind_speed],
#     wind_direction: ride[:wind_direction],
#     wind_gust: ride[:wind_gust],
#     longitude: ride[:longitude],
#     latitude: ride[:latitude]
#     )
# end

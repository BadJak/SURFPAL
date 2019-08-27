# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Ride.destroy_all
Userride.destroy_all
Beach.destroy_all

beaches = []
beaches_url = []
beaches_url << urlFRA = "https://magicseaweed.com/France-Surf-Forecast/2/"
beaches_url << urlMAR = "https://magicseaweed.com/Maroc-Surf-Forecast/12/"
beaches_url << urlESPOR = "https://magicseaweed.com/Espagne-Portugal-Surf-Forecast/8/"

beaches_url.each do |beach_url|
  response = Faraday.get "https://magicseaweed.com/#{beach_url}"
  html_doc = Nokogiri::HTML(response.body)
  data = html_doc.search('#msw-js-map')
  array = data.first['data-collection']
  data = JSON.parse(array).each do |element|
    if element['country']['iso'] == 'fr'
      country = 'France'
    elsif element['country']['iso'] == 'ma'
      country = 'Morocco'
    elsif element['country']['iso'] == 'pt'
      country = 'Portugal'
    elsif element['country']['iso'] == 'es'
      country = 'Spain'
    end
    beaches << {
      name: element['name'],
      description: element['description'],
      longitude: element['lon'],
      latitude: element['lat'],
      country: country
      }
  end
end

beaches.each do |beach|
  Beach.create(
  name: beach[:name],
  description: beach[:description],
  longitude: beach[:longitude],
  latitude: beach[:latitude],
  country: beach[:country]
  )
  # b.remote_photo_url = beach[:image_url]
  # b.save
end

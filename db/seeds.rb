# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

beaches = []
beaches_url = []
beaches_url << "https://magicseaweed.com/Royaume-Uni-Irlande-Surf-Forecast/1/"
beaches_url << "https://magicseaweed.com/Nouvelle-Zelande-Surf-Forecast/4/"
beaches_url << "https://magicseaweed.com/California-Nord-Surf-Forecast/16/"
beaches_url << "https://magicseaweed.com/California-Sud-Surf-Forecast/17/"
beaches_url << "https://magicseaweed.com/Mexique-Baja-Surf-Forecast/18/"
beaches_url << "https://magicseaweed.com/Mexique-Pacific-Surf-Forecast/19/"
beaches_url << "https://magicseaweed.com/Floride-Surf-Forecast/20/"
beaches_url << "https://magicseaweed.com/Central-America-Nord-Surf-Forecast/28/"
beaches_url << "https://magicseaweed.com/Central-America-Sud-Surf-Forecast/29/"
beaches_url << "https://magicseaweed.com/Bresil-Sud-Surf-Forecast/36/"
beaches_url << "https://magicseaweed.com/Bresil-Est-Surf-Forecast/37/"
beaches_url << "https://magicseaweed.com/Bresil-Nord-est-Surf-Forecast/38/"
beaches_url << "https://magicseaweed.com/Sud-Ouest-Australie-Surf-Forecast/44/"
beaches_url << "https://magicseaweed.com/Sud-Australie-Surf-Forecast/45/"
beaches_url << "https://magicseaweed.com/iles-sous-le-vent-Surf-Forecast/46/"
beaches_url << "https://magicseaweed.com/Nouvelle-Galles-du-Sud-Surf-Forecast/47/"
beaches_url << "https://magicseaweed.com/Queensland-Surf-Forecast/48/"
beaches_url << "https://magicseaweed.com/Tasmanie-Surf-Forecast/49/"
beaches_url << "https://magicseaweed.com/Polynesie-francaise-Surf-Forecast/62/"
beaches_url << "https://magicseaweed.com/Nord-Ouest-Australie-Surf-Forecast/77/"
beaches_url << "https://magicseaweed.com/California-Central-Surf-Forecast/83/"
beaches_url << "https://magicseaweed.com/Colombie-Surf-Forecast/87/"


beaches_url.each do |beach_url|
  response = Faraday.get "https://magicseaweed.com/#{beach_url}"
  html_doc = Nokogiri::HTML(response.body)
  data = html_doc.search('#msw-js-map')
  array = data.first['data-collection']
  data = JSON.parse(array).each do |element|
    if element['country']['iso'] == 'england'
      country = 'UK'
    elsif element['country']['iso'] == 'wales'
      country = 'UK'
    elsif element['country']['iso'] == 'scotland'
      country = 'UK'
    elsif element['country']['iso'] == 'gg'
      country = 'UK'
    elsif element['country']['iso'] == 'ie'
      country = 'Ireland'
    elsif element['country']['iso'] == 'us'
      country = 'USA'
    elsif element['country']['iso'] == 'nz'
      country = 'New Zealand'
    elsif element['country']['iso'] == 'au'
      country = 'Australia'
    elsif element['country']['iso'] == 'mx'
      country = 'Mexico'
    elsif element['country']['iso'] == 'gt'
      country = 'Guatemala'
    elsif element['country']['iso'] == 'sv'
      country = 'El Salvador'
    elsif element['country']['iso'] == 'gt'
      country = 'Guatemala'
    elsif element['country']['iso'] == 'cr'
      country = 'Costa Rica'
    elsif element['country']['iso'] == 'pa'
      country = 'Panama'
    elsif element['country']['iso'] == 'ni'
      country = 'Nicaragua'
    elsif element['country']['iso'] == 'br'
      country = 'Brazil'
    elsif element['country']['iso'] == 'co'
      country = 'Colombia'
    elsif element['country']['iso'] == 'br'
      country = 'Brazil'
    elsif element['country']['iso'] == 'pf'
      country = 'French Polynesia'
    else country = ''
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
end

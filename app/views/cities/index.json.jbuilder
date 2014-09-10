json.array!(@cities) do |city|
  json.extract! city, :id, :name, :country
  json.url city_url(city, format: :json)
end

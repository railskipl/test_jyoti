json.array!(@sponsers) do |sponser|
  json.extract! sponser, :id, :name, :custom_factor
  json.url sponser_url(sponser, format: :json)
end

json.array!(@influences) do |influence|
  json.extract! influence, :id, :your_influence, :influence_on_your
  json.url influence_url(influence, format: :json)
end

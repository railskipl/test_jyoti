json.array!(@tips) do |tip|
  json.extract! tip, :id, :praise, :criticism, :helpful_tips
  json.url tip_url(tip, format: :json)
end

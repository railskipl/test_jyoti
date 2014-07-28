json.array!(@score_factors) do |score_factor|
  json.extract! score_factor, :id, :name, :description
  json.url score_factor_url(score_factor, format: :json)
end

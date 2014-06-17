json.array!(@factors) do |factor|
  json.extract! factor, :id, :name, :circle_id
  json.url factor_url(factor, format: :json)
end

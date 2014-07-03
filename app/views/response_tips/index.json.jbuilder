json.array!(@response_tips) do |response_tip|
  json.extract! response_tip, :id, :tip_id, :response_for_tip, :tag_tip, :user_id
  json.url response_tip_url(response_tip, format: :json)
end

json.array!(@relationships) do |relationship|
  json.extract! relationship, :id, :email, :know_how_for_long_year, :know_how_for_long_month, :how_well_you_know_the_person, :your_influence, :influence_on_your, :user_id
  json.url relationship_url(relationship, format: :json)
end

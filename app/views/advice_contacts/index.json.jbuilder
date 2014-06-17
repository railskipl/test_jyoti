json.array!(@advice_contacts) do |advice_contact|
  json.extract! advice_contact, :id, :email, :praise, :criticism, :helpful_tips
  json.url advice_contact_url(advice_contact, format: :json)
end

json.array!(@sponsees) do |sponsee|
  json.extract! sponsee, :id, :user_id, :relationship_id, :email, :approve_admin_custom_factor, :your_choise_custom_factor
  json.url sponsee_url(sponsee, format: :json)
end

json.array!(@sponsercfs) do |sponsercf|
  json.extract! sponsercf, :id, :sponser_id, :user_id, :name, :custom_factor_string, :email
  json.url sponsercf_url(sponsercf, format: :json)
end

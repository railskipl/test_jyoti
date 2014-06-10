json.array!(@paste_users) do |paste_user|
  json.extract! paste_user, :id, :user_id, :name, :email
  json.url paste_user_url(paste_user, format: :json)
end

json.array!(@sponsee_approvals) do |sponsee_approval|
  json.extract! sponsee_approval, :id, :approve_custom_factor, :custom_factor, :your_choise_custom_factor
  json.url sponsee_approval_url(sponsee_approval, format: :json)
end
